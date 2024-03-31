from django.shortcuts import render
from rest_framework import viewsets
from .serializer import PDF_serializer
from .models import PDF_model

# Create your views here.
class PDF_view(viewsets.ModelViewSet):
    serializer_class = PDF_serializer
    queryset = PDF_model.objects.all()