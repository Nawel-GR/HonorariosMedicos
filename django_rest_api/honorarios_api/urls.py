from django.urls import path, include
from rest_framework import routers
from .views import  File_extraction, File_upload, Create_Doctor


urlpatterns = [
    path('upload-file/', File_extraction.as_view(), name='upload_jpg'),
    path('upload-firebase/', File_upload.as_view(), name='upload_firebase'),
    path("Create-Doctor/", Create_Doctor.as_view(), name="Create-Doctor"),
]