import requests

def make_google_consult(token, data_json, url):
    """Makes a post request to the google api with the token and the data_json
    
    Arguments:
        token {str} -- The token to access the google api
        data_json {json} -- The data to send to the google api
        url {str} -- The url to send the request
    
    Returns:
        response -- The response from the google api
    """

    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }

    try:
        response = requests.post(url, headers=headers, json=data_json)

        if response.status_code == 200:
            print("Success")
            return response
        else:
            print(f"Error code: {response.status_code}")
            #print("Message", response.text)
    except Exception as e:
        print(f"Error Catch: {str(e)}")



def make_json(base64, file_type):
    """Makes a json with the base64 file
    
    Arguments:
        base64 {str} -- The base64 file
        file_type {str} -- The file type
    
    Returns:
        json -- The json with the base64 file
    """
    return {
    "skipHumanReview": "true",
    "rawDocument": {
      "mimeType": file_type,
      "content": f"{base64}"
    }
  }
