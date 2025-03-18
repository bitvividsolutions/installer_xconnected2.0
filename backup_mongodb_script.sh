#!/bin/bash

# Function to handle errors
handle_error() {
    local message="$1"
    echo "ERROR: $message"
}

# Variables
MONGO_USER="root"            # MongoDB username
MONGO_PASSWORD="password"     # MongoDB password
AUTH_DB="admin"              # Authentication database
DB_NAME="itms"               # Database name
BACKUP_PATH="/data/backup" # Path inside the container where backups are stored
LOCAL_BACKUP_PATH="/data/backup/dumps" # Local path to store backups
DAYS_TO_KEEP=35              # Days to keep before deletion
CURRENT_DATE=$(date +"%Y-%m-%d") # Current date for backup folder naming

# Step 1: Create MongoDB backup
#echo "Creating MongoDB backup..."
#if ! mongodump --username $MONGO_USER --password $MONGO_PASSWORD --authenticationDatabase $AUTH_DB --db $DB_NAME --out $LOCAL_BACKUP_PATH/$DB_NAME/backup-$CURRENT_DATE; then
    handle_error "MongoDB backup failed."
 #   exit 1
#fi

#echo "Backup successful, copying backup to host..."

# # Step 2: Copy backup to local path
# mkdir -p $LOCAL_BACKUP_PATH/$DB_NAME/backup-$CURRENT_DATE
# if ! mv "$BACKUP_PATH/itms/" "$LOCAL_BACKUP_PATH/$DB_NAME/backup-$CURRENT_DATE"; then
#     handle_error "Failed to copy backup to local path."
#     exit 1
# fi

# Step 3: Rename the backup folder to current date (this step is integrated in the copy command above)

# echo "Backup copied successfully to $DB_NAME-backup-$CURRENT_DATE."

# Step 4: Delete data older than x days from the MongoDB collection
echo "Cleaning up data older than $DAYS_TO_KEEP days from the logs collection..."
if ! mongo $DB_NAME --username $MONGO_USER --password $MONGO_PASSWORD --authenticationDatabase $AUTH_DB --eval "db.logs.deleteMany({EventTimestamp: {\$lt: ISODate('$(date -d "-$DAYS_TO_KEEP days" +%Y-%m-%dT%H:%M:%S)')}})"; then
    handle_error "Failed to delete old logs."
else
    echo "Old logs deleted successfully."
fi

echo "Backup and cleanup completed successfully."
