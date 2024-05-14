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

# get a document reference from Firestore
def read_document_reference(collection, document_id):
    """
    Args : 
    """
    try:
        db = firestore.client()
        doc_ref = db.collection(collection).document(document_id)
        
        return doc_ref
    except:
        return None
    
# create a subcollection
def create_subcollection(doc_ref, subcollection_name, document_name, params):
    """
    Args : 
    """
    try:
        subcollection = doc_ref.collection(subcollection_name).document(document_name)
        subcollection.set(params)
    except Exception as e:
        print(e)

# Create a new document in Firestore
def create_document(collection, document_data, document_name):
    try:
        db = firestore.client()
        doc_ref = db.collection(collection).document(document_name)
        doc_ref.set(document_data)
    
    except Exception as e:
        print("consulta no creada")
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

def create_worked_day(doctor_id, clinic_id, document_name):
    db = firestore.client()

    doctor_ref = db.collection("doctors").document(doctor_id)
    clinic = db.collection("clinics").document(clinic_id)

    create_document("worked_day", {
        "doctor": doctor_ref,
        "clinic": clinic,
    }, document_name)

