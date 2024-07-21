from .serializer import File_serializer
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import HttpResponse
import json
from .Connections.google_api import make_google_consult, make_json
from drf_yasg.utils import swagger_auto_schema

# import Json key
from .keys.get_key import get_google_url_paids, get_access_token_old, get_google_url_class, get_google_url_hours
from .utils.matcher import match_patients

# Clinicas
from firebase_admin import firestore
from django.views.decorators.csrf import csrf_exempt

# Utils
from .utils.mapping import map_clinic_alemana_cas_paid, map_clinic_alemana_cas_hours
from .utils.crud_firebase import create_document, read_document, create_worked_day, read_document_reference, create_subcollection, update_document
from .utils.parser import parse_date, parse_date_2

DEBUG = True
GOOGLE_KEY = get_access_token_old()

class Create_Doctor(APIView):
    """Function to create a doctor on the Firebase database
        
    """
    def post(self, request):

        data = request.data
        
        # Getting the data
        d_name = data["names"]
        d_lastname = data["last_names"]
        d_rut = data["rut"]
        clinic = data["clinic_id"]

        # Verifying if the data is correct
        if len(d_rut) != 8:
            return Response("Rut is not on a correct format", status=status.HTTP_400_BAD_REQUEST)


        # Creating the document on firebase
        document_name = f"{d_rut[:-4]}{clinic}"
        document_data = {
            "names": d_name,
            "last_names": d_lastname,
            "rut": d_rut,
        }

        # Verifying if the doctor exists
        if not read_document("doctors", document_name):
            create_document("doctors", document_data, document_name)

        else:
            return Response("Doctor already exists", status=status.HTTP_400_BAD_REQUEST)
        
        return Response("Doctor created", status=status.HTTP_200_OK)

class File_extraction(APIView):
    @swagger_auto_schema(
        request_body=File_serializer,
        responses={200: File_serializer()}
    )
    def post(self, request):
        serializer = File_serializer(data=request.data)
        if serializer.is_valid():
            #serializer.save() # Save the file in the local database
            try:
                return classifier_document(serializer.data)
            except Exception as e:
                return Response(str(e), status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
def classifier_document(data):
    """ Function to classify the document by 2 categories:
        - Pago-CAS (CLINICA ALEMANA)
        - Atencion (CLINICA ALEMANA)
    """
    
    if DEBUG:
        print("classifying document")

    b64_file = data["binary"] # Getting the binary file
    clinic = data["clinic"] # Getting the clinic
    file_type = data["file_type"] # Getting the file type

    json_req = make_json(b64_file, file_type) # Making the json to the cloud request

    # Send the jpg file to google
    url = get_google_url_class() # Getting URL

    # Receive the jpg file
    response = make_google_consult(GOOGLE_KEY, json_req, url) # Making the request

    response_decoded = json.loads(response.content) # Decoding the response

    # Getting the entities keys
    entities = response_decoded["document"]["entities"]

    # Getting the entities keys values
    class_id = {
        "type": None,
        "confidence": 0
    } # Default value

    for entity in entities:
        if float(entity['confidence']) > class_id['confidence']:
            class_id['type'] = entity['type']
            class_id['confidence'] = entity['confidence']

    """
    ¡¡¡INCLUDE TRY EXCEPT!!!
    """
    
    # After the clasification. Sends the data to the correct function
    if class_id['type'] == "Pago-CAS":
        if DEBUG:
            print("Pago CAS")
            
        return extract_CAS_pago(data)

    elif class_id['type'] == "Atencion-CAS":
        if DEBUG:
            print("Atencion CAS")
        return extract_CAS_atencion(data)

    else:
        return Response("Document class not found", status=status.HTTP_400_BAD_REQUEST)
    
def extract_CAS_atencion(data):
    """ Sends the data to GCP and returns the data mapped
    Args:
        data (dict): Data from the request
    
    """

    if DEBUG:
        print("Received file")

    # Extracts the information from the data
    b64_file = data["binary"]
    #med = data["med"]
    clinic = data["clinic"]
    file_type = data["file_type"]

    json_test = make_json(b64_file, file_type)  # makes a json with the information

    # sends the jpg file to the specific url GCP extractor.
    url = get_google_url_hours() 

    # Receive the jpg file
    google_response = make_google_consult(GOOGLE_KEY, json_test, url)
    google_decoded = json.loads(google_response.content)

    if DEBUG:
        print("Received Google Response")

    entities = google_decoded["document"]["entities"] # Getting the entities keys

    # Getting the entities keys values
    if clinic == "Clinica Alemana":
        response = map_clinic_alemana_cas_hours(entities)

    else:
        return Response("Clinic not found", status=status.HTTP_400_BAD_REQUEST)
    
    if DEBUG:
        print("Data Mapped")
        print(response)

    return Response(response, status=status.HTTP_200_OK)

def extract_CAS_pago(data):
    """ Sends the data to GCP and returns the data mapped
    Args:
        data (dict): Data from the request
    
    """

    if DEBUG:
        print("Received file")
    
    # Extracts the information from the data
    b64_file = data["binary"]
    #med = data["med"]
    clinic = data["clinic"]
    file_type = data["file_type"]

    json_test = make_json(b64_file, file_type)# makes a json with the information

    url = get_google_url_paids() # Send the jpg file to GCP extractor

    google_response = make_google_consult(GOOGLE_KEY, json_test, url) # Receive the jpg file
    google_decoded = json.loads(google_response.content) # Decoding the response

    if DEBUG:
        print("Received Google Response")

    entities = google_decoded["document"]["entities"] # Getting the entities keys

    # Getting the entities keys values. ASUMING THAT THE CLINIC IS CLINICA ALEMANA
    if clinic == "Clinica Alemana":
        response = map_clinic_alemana_cas_paid(entities)

    else:
        return Response("Clinic not found", status=status.HTTP_400_BAD_REQUEST)

    if DEBUG:
        print("Data Mapped")
        print(response)

    """
    Matching section
    In the future, implement a matching function that connects the data with the firebase database
    now, all completed attentions will be send as matched
    
    matched_response = match_patients(response)
    """

    # return response
    return Response(response, status=status.HTTP_200_OK)

class new_file_upload(APIView):
    """ Class to upload the data extracted from the files to the firebase database
    """

    def post(self, request):
        data = request.data

        # Getting Type
        type_ = data["type"]

        if type_ == "Atencion-CAS": # upload Atencion CAS
            print('Atencion CAS')
            return firebase_upload_atencion(data['data'], data['clinic'], data["professional"])

        elif type_ == "Pago-CAS": # upload Pago CAS
            print('Pago CAS')
            return firebase_upload_pago(data['data'], data['clinic'], data["professional"])
        else:
            return Response("Type not found", status=status.HTTP_400_BAD_REQUEST)
    
def firebase_upload_atencion(data, clinic, professional_id):
    """ Upload the data to the firebase database.
    Args:
        data (dict): Data extracted from the file
        clinic (str): Clinic name
        professional_id (str): MED ID
    """

    if clinic != "Clinica Alemana":
        return Response("Clinic not found", status=status.HTTP_400_BAD_REQUEST)
    
    clinic_id = "001" #TODO get clinic id

    # Getting the date
    date = data["date"]['value']
    date = parse_date(date) # TODO better parser

    # Getting the patients
    patients = data["patients"] 

    patients_to_firebase = []

    for patient in patients:  # iterating over the patients
        if patient['Estado']['value'] == "Completado":

            name = patient['Nombre']['value']
            name = name.split(" ")
            name = "".join([i[0] for i in name])

            if len(name) < 4:
                name+='x'

            #TODO ORDER THE NAMES AND LASTNAMES
            patients_to_firebase.append(name)
           
    if DEBUG:
        print("Patients to firebase")
        print(patients_to_firebase)
        print(f"Professional ID: {professional_id}")

    # Create worked day on firebase
    doc_name = f"{professional_id}{clinic_id}{date}"
    create_worked_day(str(professional_id), clinic_id, doc_name)
    print(f"WORKDED DAY CREATED {doc_name}")

    worked_day_ref = read_document_reference("worked_day", doc_name)  # Getting the reference of 'worked day'

    # Adding patients
    i = 1
    for patient in patients_to_firebase:
        worked_name = f"{patient}{professional_id}{date}"

        values ={
                "names" : patient,
                "pagado" : 0, #0: not paid, 1: paid, 2:conflict
            }

        # Create the document on firebase
        create_document("consults", values, worked_name)
        p_ref = read_document_reference("consults", worked_name)
        create_subcollection(worked_day_ref, "dayconsults", str(i), {"consult_ref" : p_ref})

        i+=1

    return Response("Data uploaded", status=status.HTTP_200_OK)

def firebase_upload_pago(data, clinic, professional_id):
    """ Upload the data to the firebase database.
    Args:
        data (dict): Data extracted from the file
        clinic (str): Clinic name
        professional_id (str): MED ID
    """

    if clinic != "Clinica Alemana":
        return Response("Clinic not found", status=status.HTTP_400_BAD_REQUEST)
    
    clinic_id = "001" #TODO get clinic id

    date = data["date"]['value']
    date = parse_date_2(date) # TODO better parser

    # Getting the total values
    total_Total = data["total"]['Total']['value']
    total_Descuento = data["total"]['Descuento']['value']
    total_Valor = data["total"]['Valor']['value']

    # Upload the total values to worked day
    doc_name = f"{professional_id}{clinic_id}{date}"
    worked_day_ref = read_document_reference("worked_day", doc_name)  # Getting the reference

    update_data = {
        "total_Total" : total_Total,
        "total_Descuento" : total_Descuento,
        "total_Valor" : total_Valor
    }

    update_document("worked_day", doc_name, update_data)  # Updating informartion

    # Iterate over the patients
    patients = data["patients"]
    l_parsed = {}

    for patient in patients:
        name = patient['Nombre']['value']
        name = name.split(" ")
        name = "".join([i[0] for i in name])

        if len(name) < 4: #TODO better name extraction
            name+='x'

        l_parsed[name] = {
            "Descuento" : patient['Descuento']['value'],
            "Total" : patient['Total']['value'],
            "Valor" : patient['Valor']['value']
        }

    # TODO in case that patients doesn't exists
    for key, value in l_parsed.items():
        doc_name = f"{key}{professional_id}{date}"
        update_data = {
            "pagado" : 1,
            "total" : value["Total"],
            "descuento" : value["Descuento"],
            "valor" : value["Valor"]
        }

        update_document("consults", doc_name, update_data) # To firebase

    return Response(l_parsed, status=status.HTTP_200_OK)