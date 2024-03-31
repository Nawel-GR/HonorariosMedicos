from rest_framework import serializers
from .models import PDF_model

class PDF_serializer(serializers.ModelSerializer):
    class Meta:
        model = PDF_model
        fields = '__all__'


