from .serializer import File_serializer
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from .mapping import map_clinic_alemana
import json
from .Connections.google_api import make_google_consult, make_json

from drf_yasg.utils import swagger_auto_schema


# import Json key
from .keys.get_key import get_google_url, get_access_token_old


# Clinicas
from .Clinicas.clinica_alemana import Clinica_Alemana


DEBUG = True

class File_view(APIView):
    @swagger_auto_schema(
        request_body=File_serializer,
        responses={200: File_serializer()}
    )
    def post(self, request):
        serializer = File_serializer(data=request.data)
        if serializer.is_valid():
            #serializer.save()
            try:
                return manage_file(serializer.data)
            except Exception as e:
                return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        


def manage_file(data):

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
