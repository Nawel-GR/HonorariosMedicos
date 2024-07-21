"""
Crud operations to firebase DDBB connection
consult with nahuel.gomez@ug.uchile.cl for more information.
"""
from firebase_admin import firestore

def read_document(collection, document_id):
    """ Reads a document from Firestore
    Args:
        collection (str): Collection's document name
        document_id (str): Document ID
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

def read_document_reference(collection, document_id):
    """ Gets a document reference from Firestore by the document ID
    Args:
        collection (str): Collection's document name
        document_id (str): Document ID 

    Returns:
        doc_ref (DocumentReference): Document reference
    """
    try:
        db = firestore.client()
        doc_ref = db.collection(collection).document(document_id)
        
        return doc_ref
    except:
        return None
    
def create_subcollection(doc_ref, subcollection_name, document_name, params):
    """ Creates a subcollection
    Args:
        doc_ref (DocumentReference): Document reference
        subcollection_name (str): Subcollection name
        document_name (str): Document name
        params (dict): Dictionary with the parameters 
    """
    try:
        subcollection = doc_ref.collection(subcollection_name).document(document_name)
        subcollection.set(params)
    except Exception as e:
        print(e)

def create_document(collection, document_data, document_name):
    """ Creates a document in Firestore
    
    Args:
        collection (str): Collection's document name
        document_data (dict): Dictionary with the document data
        document_name (str): Document name
    """
    try:
        db = firestore.client()
        doc_ref = db.collection(collection).document(document_name)
        doc_ref.set(document_data)
    
    except Exception as e:
        print("consulta no creada")
        print(e)


def update_document(collection, document_id, update_data):
    """ Updates a document in Firestore
    
    Args:
        collection (str): Collection's document name
        document_id (str): Document ID
        update_data (dict): Dictionary with the data to update
    """
    try:
        db = firestore.client()
        doc_ref = db.collection(collection).document(document_id)
        doc_ref.update(update_data)

    except Exception as e:
        print(e)

def delete_document(collection, document_id):
    """ Deletes a document from Firestore

    Args:
        collection (str): Collection's document name
        document_id (str): Document ID
    """
    db = firestore.client()
    doc_ref = db.collection(collection).document(document_id)
    doc_ref.delete()
    print('Document deleted successfully!')

def create_worked_day(doctor_id, clinic_id, document_name):
    """ Creates a worked day document in Firestore
    
    Args:
        doctor_id (str): Doctor's ID
        clinic_id (str): Clinic's ID
        document_name (str): Document name
    """
    db = firestore.client()

    doctor_ref = db.collection("doctors").document(doctor_id)
    clinic = db.collection("clinics").document(clinic_id)

    create_document("worked_day", {
        "doctor": doctor_ref,
        "clinic": clinic,
    }, document_name)

