from django.urls import path, include
from rest_framework import routers
from .views import  File_upload, Read_wordek_day,Create_wordek_day


urlpatterns = [
    path('upload-file/', File_upload.as_view(), name='upload_jpg'),
    path('get-worked-day/', Read_wordek_day.as_view(), name='read_wordek_day'),
    path('create-worked-day/', Create_wordek_day.as_view(), name='create_wordek_day'),
]