from django.urls import path, include
from rest_framework import routers
from .views import PDF_view, UploadPhoto

#api version
router = routers.DefaultRouter()
router.register(r'pdf', PDF_view, basename='pdf')

urlpatterns = [
    path('file', include(router.urls)),
    path('upload-jpg/', UploadPhoto.as_view(), name='upload_jpg'),
]