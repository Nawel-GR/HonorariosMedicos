from .serializer import File_serializer
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import HttpResponse
from .utils.mapping import map_clinic_alemana
from .utils.crud_firebase import create_document, read_document, create_worked_day, create_consults
import json
from .Connections.google_api import make_google_consult, make_json
from drf_yasg.utils import swagger_auto_schema

# import Json key
from .keys.get_key import get_google_url, get_access_token_old


# Clinicas
from firebase_admin import firestore

from django.views.decorators.csrf import csrf_exempt

DEBUG = True

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
                return extract_information(serializer.data)
            except Exception as e:
                return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

def extract_information(data):

    if DEBUG:
        print("Received file")
    
    b64_file = data["binary"]
    med = data["med"]
    clinic = data["clinic"]
    file_type = data["file_type"]

    json_test = make_json(b64_file, file_type)

    # Send the jpg file to google
    url = get_google_url()

    google_key = get_access_token_old()

    # Receive the jpg file

    google_response = make_google_consult(google_key, json_test, url)

    google_decoded = json.loads(google_response.content)

    if DEBUG:
        print("Received Google Response")


    # Getting the entities keys
    entities = google_decoded["document"]["entities"]

    if DEBUG:
        print("Entities keys")
        for i in entities:
            print(i['mentionText'])
            print(i['type'])

    # Getting the entities keys values

    if clinic == "Clinica Alemana":
        response = map_clinic_alemana(entities)

    else:
        response = "Clinic not supported"

    if DEBUG:
        print("Data Mapped")
        print(response)

    # return response
    return Response(response, status=status.HTTP_200_OK)

class File_upload(APIView):
    
    def post(self, request):
        
        # Creation of the consult
        #create_consults("5547001", values_l)

        # modify create_consults
        # to generate the previous instances of each consult
        # after that, create the worked day with the references of the consults

        return