import json
import boto3
import os

s3 = boto3.client("s3")

def lambda_handler(event, context):
    print("Evento recibido:", json.dumps(event))

    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    key = event["Records"][0]["s3"]["object"]["key"]

    print(f"Archivo recibido: s3://{bucket}/{key}")

    # Por ahora solo leemos el archivo
    obj = s3.get_object(Bucket=bucket, Key=key)
    content = obj["Body"].read().decode("utf-8")

    print("Contenido del TXT:")
    print(content)

    return {
        "statusCode": 200,
        "body": "Archivo procesado"
    }
