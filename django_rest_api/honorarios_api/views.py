from django.shortcuts import render
from rest_framework import viewsets
from .serializer import PDF_serializer
from .models import PDF_model
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
import csv
from django.http import HttpResponse
from .mapping import map_clinic_alemana

# import Json key
from .keys.get_key import get_google_key, get_test_json


# Clinicas
from .Clinicas.clinica_alemana import Clinica_Alemana


DEBUG = True


# Create your views here.
class PDF_view(viewsets.ModelViewSet):
    serializer_class = PDF_serializer
    queryset = PDF_model.objects.all()


import requests

def make_google_consult(token, data_json, url):

    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }

    try:
        response = requests.post(url, headers=headers, json=data_json)
        if response.status_code == 200:
            print("Success")
            return response
        else:
            print(f"Error code: {response.status_code}")
            #print("Message", response.text)
    except Exception as e:
        print(f"Error Catch: {str(e)}")

def make_json(base64):
    return {
    "skipHumanReview": "false",
    "rawDocument": {
      "mimeType": "application/pdf",
      "content": f"{base64}"
    }
  }


class UploadPhoto(APIView):
    def post(self, request, format = None):

        #if 'jpg-file' not in request.FILES:
        #    return Response({"error": "No file uploaded"}, status=status.HTTP_400_BAD_REQUEST)
        
        #jpg_file = request.FILES['jpg-file']
        json_test = make_json(request.data["jpg-file"])


        # Send the jpg file to google
        google_key, url = get_google_key()

        if DEBUG:
            print("Good LOG")
        
        # Receive the jpg file
        google_response = make_google_consult(google_key, json_test, url)
        print(google_response)
        # Getting the entities keys
        entities = google_response.content.decode()["document"]["entities"]
        print("asd")
        if DEBUG:
            print("Entities keys")
            for i in entities:
                print(i.keys())

        # Getting the entities keys values
        entities_values = google_response.data["document"]["entities"]

        response = map_clinic_alemana(entities_values)

        print(response)

        # return response
        return Response(response, status=status.HTTP_200_OK)

