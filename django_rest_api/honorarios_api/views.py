from .serializer import File_serializer
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import HttpResponse
from .utils.mapping import map_clinic_alemana_cas_paid, map_clinic_alemana_cas_hours
from .utils.crud_firebase import create_document, read_document, create_worked_day, read_document_reference, create_subcollection
import json
from .Connections.google_api import make_google_consult, make_json
from drf_yasg.utils import swagger_auto_schema

# import Json key
from .keys.get_key import get_google_url_paids, get_access_token_old, get_google_url_class, get_google_url_hours
from .utils.matcher import match_patients

# Clinicas
from firebase_admin import firestore

from django.views.decorators.csrf import csrf_exempt

DEBUG = True
GOOGLE_KEY = get_access_token_old()

class Create_Doctor(APIView):
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
            #serializer.save()
            try:
                #return extract_pago_cas(serializer.data)
                return classifier_document(serializer.data)
            except Exception as e:
                return Response(str(e), status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
def classifier_document(data):
    if DEBUG:
        print("classifying document")

    b64_file = data["binary"]
    clinic = data["clinic"]
    file_type = data["file_type"]

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

    #return Response(class_id['type'], status=status.HTTP_200_OK)
    """
    Modificar
    """
    if class_id['type'] == "Pago-CAS":
        if DEBUG:
            print("Pago CAS")
        return extract_pago_cas(data)

    elif class_id['type'] == "Atencion-CAS":
        if DEBUG:
            print("Atencion CAS")
        return extract_pago_atencion(data)

    else:
        return Response("Document class not found", status=status.HTTP_400_BAD_REQUEST)
    
def extract_pago_atencion(data):

    if DEBUG:
        print("Received file")

    b64_file = data["binary"]
    med = data["med"]
    clinic = data["clinic"]
    file_type = data["file_type"]

    json_test = make_json(b64_file, file_type)

    url = get_google_url_hours() # send the jpg file

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


def extract_pago_cas(data):

    if DEBUG:
        print("Received file")
    
    b64_file = data["binary"]
    med = data["med"]
    clinic = data["clinic"]
    file_type = data["file_type"]

    json_test = make_json(b64_file, file_type)

    url = get_google_url_paids() # Send the jpg file to google

    google_response = make_google_consult(GOOGLE_KEY, json_test, url) # Receive the jpg file
    google_decoded = json.loads(google_response.content)

    if DEBUG:
        print("Received Google Response")

    entities = google_decoded["document"]["entities"] # Getting the entities keys

    # Getting the entities keys values
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
    """
    matched_response = match_patients(response)

    # return response
    return Response(matched_response, status=status.HTTP_200_OK)

class File_upload(APIView):
    
    def post(self, request):

        data = request.data

        # Getting the data
        clinic = data["clinic"] #Exists

        #TODO create get clinic id
        clinic_id = "001"

        professional = data["data"]["profesional"]["value"]
        code_id = professional.split("-")[0][:-4]

        profesional_id = f"{code_id}{clinic_id}"

        date = data["data"]["date"]["value"]

        #TODO create a get date
        date_o = date.split(" ")[1].replace('/', '')
        date_yymmdd = f"{date_o[6:]}{date_o[2:4]}{date_o[:2]}"


        total = data["data"]["total"]["value"]

        # Create worked day
        doc_name = f"{profesional_id}{date_yymmdd}"
        create_worked_day(profesional_id, clinic_id, doc_name)

        print(f"WORKDED DAY CREATED {doc_name}")

        worked_day_ref = read_document_reference("worked_day", doc_name)

        
        # Adding patients
        patient_list = data["data"]["pacients"]

        i = 1
        for patient in patient_list:
            name = patient["name"]
            name = name.split(" ")

            # get first letters and make a string
            name = "".join([i[0] for i in name])
            
            if len(name) < 4:
                name+='x'

            #TODO ORDER THE NAMES AND LASTNAMES
            values ={
                "names" : patient["name"],
            }

            worked_name = f"{name}{profesional_id}{date_yymmdd}"

            create_document("consult", values, worked_name)

            p_ref = read_document_reference("consult", worked_name)


            create_subcollection(worked_day_ref, "dayconsults", str(i), {"consult_ref" : p_ref})
            i+=1


        return Response("File uploaded", status=status.HTTP_200_OK)