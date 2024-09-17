import json
import boto3

dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('Viewcount')

def lambda_handler(event, context):
    resp = table.get_item(Key={"ID": "Views"})
    curviews = resp["Item"]["Viewcount"]
    newviews = int(curviews) + 1

    with table.batch_writer() as batch:
        batch.put_item(Item={"ID": "Views", "Viewcount": newviews})
    
    return {
        'Viewcount': newviews
    }

