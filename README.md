# HonorariosMedicos

Creación de MVP para una aplicación movil para gestionar pagos medicos

## Descripción

Primera Iteración de Honorarios Médicos : Flutter - Firebase - Google Cloud

## Getting Started

### Dependencias

* Flutter
* Npm
* Django
* Google Cloud CLI
* Firebase CLI
* Windows 11 (Para correr el backend)

### Instalación

* Clonar repositorio
```
git clone https://github.com/Nawel-GR/HonorariosMedicos.git
```
* Instalar dependencias
* Crear ambiente virtual
```
python -m venv honorMedEnv
```

* Abrir ambiente
```
#cmd
honorMedEnv\Scripts\activate.bat

#Powershell
honorMedEnv\Scripts\Activate.ps1
```
* Instalar librerias necesarias
```
pip install requirements.txt

flutter pub get
```


### Executar

* Correr el back-end
```
python manage.py runserver
```
* Correr la App
```
flutter run
```

* Para debuggear en Android es necesario instalar android studio y seguir las intrucciones de instalación de google

### Notas

Es necesario mantener las llaves de acceso a firebase y google en una carpeta fuera de github ya que son privadas, estas estan en un archivo separado que no esta subido aquí sin este la aplicación no puede acceder a la base de datos, ni a la IA de manipulación de texto


## Ayuda

Para solicitar las credenciales:

Nahuel Gomez: nahuel.rag@ug.uchile.cl

Diego Navarrete: dinavarrete@ug.uchile.cl
