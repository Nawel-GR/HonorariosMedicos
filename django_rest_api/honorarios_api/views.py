from django.shortcuts import render
from rest_framework import viewsets
from .serializer import File_serializer
from .models import File_model
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
import csv
from django.http import HttpResponse
from .mapping import map_clinic_alemana
import json

from drf_yasg.utils import swagger_auto_schema


# import Json key
from .keys.get_key import get_google_key, get_test_json


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
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


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
        google_decoded = json.loads(google_response.content)

        if DEBUG:
            print("Google Response")
            print(google_decoded)


        # Getting the entities keys
        entities = google_decoded["document"]["entities"]
        print("asd")

        if DEBUG:
            print("Entities keys")
            for i in entities:
                print(i['mentionText'])
                print(i['type'])

        # Getting the entities keys values

        response = map_clinic_alemana(entities)

        print(response)

        # return response
        return Response(response, status=status.HTTP_200_OK)

