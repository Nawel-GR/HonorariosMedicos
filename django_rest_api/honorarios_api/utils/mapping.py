import json

THRESHOLD = 0.2
DEBUG = True

def map_clinic_alemana(entities):

    # Create a empty json
    json_response = {
        "clinic" : "Clinica Alemana",
        "data" : {

        }
    }

    patients = []

    for entity in entities:
        if DEBUG:
            print("ENTITY VALUE:")
            print(entity)
            print("END")
        type_entity = entity["type"]
        confidence_entity = entity["confidence"]

        if type_entity == "Paciente":
            properties = entity["properties"]

            values = {}
            for prop in properties:
                values[prop["type"]] = {
                    "value" : prop["mentionText"],
                    "confidence" : prop["confidence"]
                }

            patients.append(values)

        elif type_entity == "Fecha":
            values = {
                "value" : entity["mentionText"],
                "confidence" : confidence_entity
            }

            json_response["data"]["date"] = values

        elif type_entity == 'Pagos':
            properties = entity["properties"]

            values = {}
            for prop in properties:
                values[prop["type"]] = {
                    "value" : int(prop["mentionText"].replace('.','')),
                    "confidence" : prop["confidence"]
                }
            
            json_response["data"]["total"] = values

        elif type_entity == 'Medico':
            properties = entity["properties"]

            values = {}
            for prop in properties:
                values[prop["type"]] = {
                    "value" : prop["mentionText"],
                    "confidence" : prop["confidence"]
                }

            json_response["data"]["profesional"] = values

    # Cleaning the data
    for patient in patients:
        for key, value in patient.items():
            if key == "Nombre":
                patient["Nombre"]["value"] = patient["Nombre"]["value"].replace("\n", " ")

            else:
                patient[key]["value"] = int(patient[key]["value"].replace(".", ""))

    
    json_response["data"]["pacients"] = patients

    return json_response
            

