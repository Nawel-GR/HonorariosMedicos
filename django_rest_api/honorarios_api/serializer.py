from rest_framework import serializers
from .models import File_model


class File_serializer(serializers.ModelSerializer):
    class Meta:
        model = File_model
        fields = '__all__'
