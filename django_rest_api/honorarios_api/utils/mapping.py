import json

THRESHOLD = 0.2


def map_clinic_alemana(entities):

    def map_c_entity(entity):
        """
        {
            "nombre" : "name",
            "total" : int,
            "opago" : int,
        }
        """
        # "24/05/2023 2305553492 MONTENEGRO ERRAZURIZ MARIA JESUS 2401001 CONSULTA MÉDICA PSIQUIATRÍA, ELECTIVA 24/05/2023 C021C07316 CONSULTA SIQUIATRIA 104.558 4.005 100.553"
        entity = entity.split(" ")

        opago = entity[1]
        total = entity[-1].replace(".", "")
        print("valores")
        print(opago)
        print(total)
        name = ""
        for val in entity[2:]:
            if not val.isnumeric():
                name += f" {val}"
            else:
                break
        pacient = {
            "nombre" : name[1:],
            "total" : int(total),
            "opago" : int(opago),
        }
        print(name[1:])
        return pacient
    
    # Create a empty json
    json_response = {
        "clinica" : "Clinica Alemana",
        "datos" : {

        }
    }

    pacients = []

    for entity in entities:
        type_entity = entity["type"]
        text_entity = entity["mentionText"]
        confidence_entity = entity["confidence"]

        print(entity["type"])

        if type_entity == "Campo-F": # fecha
            value = {
                    "valor" : text_entity,
                    "confidence" : float(confidence_entity)
            }

            json_response["datos"]["date"] = value

        if type_entity == "Campo-R": # profesional
            value = {
                    "valor" : text_entity,
                    "confidence" : float(confidence_entity)
            }

            json_response["datos"]["profesional"] = value

        if type_entity == "Campo-P": # paciente
            try:
                pac = map_c_entity(entity["mentionText"])
                pac["confidence"] = confidence_entity
            
            except Exception as e:
                print(e)
                pac = {
                    "nombre" : "Error",
                    "total" : 0,
                    "opago" : 0,
                    "confidence" : 0.01
                }
            
            pacients.append(pac)

        if type_entity == "Campo-T": # total pagado
            try:
                text_entity = text_entity.replace(".", "")
                text_entity = int(text_entity)
            
            except Exception as e:
                text_entity = 0
                confidence_entity = 0.01
            
            value = {
                    "valor" : text_entity,
                    "confidence" : float(confidence_entity)
            }

            json_response["datos"]["total"] = value


    json_response["datos"]["pacients"] =  pacients

    return json_response