from django.db import models

# Create your models here.
         
# File model
class File_model(models.Model):
    binary = models.CharField(max_length=500000, default='')  # file on b64
    uploaded_at = models.DateTimeField(auto_now_add=True)
    med = models.CharField(max_length=100, default='') # med name
    clinic = models.CharField(max_length=100, default='') # clinic name
    file_type = models.CharField(max_length=100, default='') # file type

    def __str__(self):
        return f"{self.med} - {self.clinic} - {self.uploaded_at}"