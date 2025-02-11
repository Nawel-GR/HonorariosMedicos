from django.urls import path, include
from rest_framework import routers
from .views import  File_extraction, Create_Doctor, new_file_upload


urlpatterns = [
    path('upload-file/', File_extraction.as_view(), name='upload_jpg'),
    path('new-upload-firebase/', new_file_upload.as_view(), name='new_upload_firebase'),
    path("Create-Doctor/", Create_Doctor.as_view(), name="Create-Doctor"),
]