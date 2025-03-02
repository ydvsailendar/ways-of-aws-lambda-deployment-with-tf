import json
import urllib.request
import os


def lambda_handler(event, context):
    url = os.getenv("API_URL")
    response = urllib.request.urlopen(url)
    data = json.loads(response.read().decode("utf-8"))
    return {"statusCode": 200, "body": json.dumps(data)}
