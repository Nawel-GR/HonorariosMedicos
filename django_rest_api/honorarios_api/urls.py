from django.urls import path, include
from rest_framework import routers
from .views import  File_view


urlpatterns = [
    path('upload-file/', File_view.as_view(), name='upload_jpg'),
]