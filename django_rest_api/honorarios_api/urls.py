from django.urls import path, include
from rest_framework import routers
from .views import  File_view, firebase_test


urlpatterns = [
    path('upload-file/', File_view.as_view(), name='upload_jpg'),
    path('firebase-test/', firebase_test, name='home-firebase'),
]