#!/bin/bash

# Define certificate and key file names
sudo mkdir -p /data/keycloak/certs
CERT_FILE="/data/keycloak/certs/keycloak.crt"
KEY_FILE="/data/keycloak/certs/keycloak.key"


# Certificate subject information
CERT_SUBJECT="/C=IN/ST=MP/L=INDORE/O=BitvividSolutions/OU=IT/CN=auth.localhost"

# Set the validity period in days (e.g., 365 for one year)
VALIDITY_DAYS=365

# Generate a self-signed certificate
sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout "$KEY_FILE" -out "$CERT_FILE" -days "$VALIDITY_DAYS" -subj "$CERT_SUBJECT"

# Check if the certificate and key were generated successfully
if [ $? -eq 0 ]; then
  echo "Certificate and key files generated successfully:"
  echo "Certificate file: $CERT_FILE"
  echo "Key file: $KEY_FILE"
else
  echo "Certificate generation failed."
fi

sudo chmod 644 $CERT_FILE
sudo chmod 644 $KEY_FILE