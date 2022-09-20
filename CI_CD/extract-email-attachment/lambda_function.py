# Imports
import json
import boto3
import email
import os
from datetime import datetime
import re

def get_timestamp():
    current = datetime.now()
    return(str(current.year) + '-' + str(current.month) + '-' + str(current.day) + '-' + str(current.hour) + '-' + str(current.minute) + '-' + str(current.second))
    
def lambda_handler(event, context):
    # Get current timestamp
    timestamp = get_timestamp()
    
    # Initiate boto3 client
    s3 = boto3.client('s3')
    
    # Get s3 object contents based on bucket name and object key; in bytes and convert to string
    data = s3.get_object(Bucket=event['Records'][0]['s3']['bucket']['name'], Key=event['Records'][0]['s3']['object']['key'])
    contents = data['Body'].read().decode("utf-8")
    
    # Given the s3 object content is the ses email, get the message content and attachment using email package
    msg = email.message_from_string(contents)
    attachment = msg.get_payload()[1]
    fromAddress = msg['from']
    regex = "\\<(.*?)\\>"
    fromAddress = re.findall(regex, fromAddress)[0]

    # Write the attachment to a temp location
    open('/tmp/attach.csv', 'wb').write(attachment.get_payload(decode=True))
    
    # Upload the file at the temp location to destination s3 bucket and append timestamp to the filename
    # Destination S3 bucket is hard coded to 'legacy-applications-email-attachment'. This can be configured as a parameter
    # Extracted attachment is temporarily saved as attach.csv and then uploaded to attach-upload-<timestamp>.csv
    try:
        s3.upload_file('/tmp/attach.csv', 'BUCKET_S3_NAME', 'FOLDER_NAME' + '/attach-upload-' + timestamp + '.csv')
        print("Upload Successful")
    except FileNotFoundError:
        print("The file was not found")
    
    # Clean up the file from temp location
    os.remove('/tmp/attach.csv')
    
    return {
        'statusCode': 200,
        'body': json.dumps('SES Email received and processed!')
    }