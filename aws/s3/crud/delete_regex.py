import boto3
import re
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# AWS Configuration
AWS_REGION = os.getenv("AWS_REGION", "us-east-1") # Default to us-east-1 if not set
AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")

# Check if required AWS credentials are set
if not AWS_ACCESS_KEY_ID or not AWS_SECRET_ACCESS_KEY:
    print("Error: Missing AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY environment variables.")
    print("Please set these in your .env file or environment.")
    exit(1) # Exit if credentials are not found

# Create S3 resource and client with explicit credentials
session = boto3.Session(
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    region_name=AWS_REGION
)
s3 = session.resource('s3')
s3_client = session.client('s3')

# Pattern to match bucket names
pattern = re.compile(r"^lambda-deployment-\d{12}-\d+$")  # Corrected to match 12-digit account ID

# Get all buckets
all_buckets = s3_client.list_buckets()['Buckets']
print(all_buckets)

for bucket in all_buckets:
    bucket_name = bucket['Name']
    if pattern.match(bucket_name):
        print(f"Processing bucket: {bucket_name}")
        try:
            # Empty bucket
            bucket_obj = s3.Bucket(bucket_name)
            bucket_obj.objects.all().delete()

            # Delete bucket
            s3_client.delete_bucket(Bucket=bucket_name)
            print(f"✅ Deleted: {bucket_name}")
        except Exception as e:
            print(f"❌ Error deleting {bucket_name}: {e}")