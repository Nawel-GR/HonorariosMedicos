
def match_patients(response):
    flag = True # to aleatority
    for patient in response['data']['patients']:
        patient['Match'] = flag

        flag = not flag

    return response