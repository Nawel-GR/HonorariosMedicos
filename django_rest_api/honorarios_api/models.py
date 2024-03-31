from django.db import models

# Create your models here.


# PDF model
class PDF_model(models.Model):
    #pdf = models.FileField(upload_to='pdfs/')
    uploaded_at = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=100, default='')
    clinic = models.CharField(max_length=100, default='')

    def __str__(self):
        return self.name