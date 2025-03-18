from minio import Minio
import datetime
import re

# MinIO Configuration
MINIO_ENDPOINT = "10.72.5.6:9000"  # e.g., "play.min.io"
ACCESS_KEY = "minio_access_key"
SECRET_KEY = "minio_secret_key"
SECURE = False  # Set to True if using HTTPS

# Initialize MinIO client
client = Minio(MINIO_ENDPOINT, access_key=ACCESS_KEY, secret_key=SECRET_KEY, secure=SECURE)

# Get current date
current_date = datetime.datetime.now()

# List all buckets
buckets = client.list_buckets()

# Regular expression to match bucket names with date format "DD-MM-YYYY"
date_pattern = re.compile(r"(\d{2})-(\d{2})-(\d{4})")

def delete_bucket_with_objects(bucket_name):
    """Delete all objects and the bucket itself."""
    objects = client.list_objects(bucket_name, recursive=True)
    for obj in objects:
        client.remove_object(bucket_name, obj.object_name)
    client.remove_bucket(bucket_name)
    print(f"Deleted bucket: {bucket_name} (including all objects)")

for bucket in buckets:
    match = date_pattern.search(bucket.name)
    if match:
        day, month, year = map(int, match.groups())
        bucket_date = datetime.datetime(year, month, day)
        
        # Check if the bucket is older than 30 days
        if (current_date - bucket_date).days > 30:
            print(f"Deleting bucket: {bucket.name} and its contents")
            delete_bucket_with_objects(bucket.name)
    else:
        print(f"Skipping bucket: {bucket.name} (no valid date format)")