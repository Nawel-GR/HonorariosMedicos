"""
Crud operations to firebase DDBB
"""
from firebase_admin import firestore

# Read a document from Firestore
def read_document(collection, document_id):
    """
    Args : 
    """
    try:
        db = firestore.client()
        doc_ref = db.collection(collection).document(document_id)
        document = doc_ref.get()
        if document.exists:
            return 1
        else:
            return 0
    except:
        return 0

# Create a new document in Firestore
def create_document(collection, document_data, document_name):
    try:
        db = firestore.client()
        doc_ref = db.collection(collection).document(document_name)
        doc_ref.set(document_data)
    
    except Exception as e:
        print(e)

# Update a document in Firestore
def update_document(collection, document_id, update_data):
    try:
        db = firestore.client()
        doc_ref = db.collection(collection).document(document_id)
        doc_ref.update(update_data)

    except Exception as e:
        print(e)

# Delete a document from Firestore
def delete_document(collection, document_id):
    db = firestore.client()
    doc_ref = db.collection(collection).document(document_id)
    doc_ref.delete()
    print('Document deleted successfully!')

def create_consults(worked_day_name, values_l):
    """ Upload the consults to the firebase
    Args :
        worked_day_name (str): The name of the worked day
        values_l (list) The list of consults
    Returns:
        Response: The response of the request
    """
    db = firestore.client()

    for i in range(len(values_l)):
        collection = db.collection("worked_day").document(worked_day_name).collection("dayconsults")
        collection.document(str(i)).set(values_l[i])

def create_worked_day(doctor_id, clinic_id, document_name):
    db = firestore.client()

    doctor_ref = db.collection("doctors").document(doctor_id)
    clinic = db.collection("clinics").document(clinic_id)

    create_document("worked_day", {
        "doctor": doctor_ref,
        "clinic": clinic,
    }, document_name)

