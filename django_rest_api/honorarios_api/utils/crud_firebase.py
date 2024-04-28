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
            return document.to_dict()
        else:
            return 0
    except:
        return 0
    
# Create a new document in Firestore
def create_document(collection, document_data):
    db = firestore.client()
    doc_ref = db.collection(collection).document()
    doc_ref.set(document_data)
    print('Document created with ID:', doc_ref.id)

# Update a document in Firestore
def update_document(collection, document_id, update_data):
    db = firestore.client()
    doc_ref = db.collection(collection).document(document_id)
    doc_ref.update(update_data)
    print('Document updated successfully!')

# Delete a document from Firestore
def delete_document(collection, document_id):
    db = firestore.client()
    doc_ref = db.collection(collection).document(document_id)
    doc_ref.delete()
    print('Document deleted successfully!')