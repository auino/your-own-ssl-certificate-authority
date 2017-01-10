#!/bin/bash

###########################
### CONFIGURATION BEGIN ###
###########################

# Certificates information

DATA_COUNTRYCODE=IT
DATA_COUNTRY=Italy
DATA_LOCATION=Genova
DATA_ORGANIZATION='My Organization Name'
DATA_EMAIL='me@myorganization.org'

BITS=4096
DAYS=3650 # 10 years

###########################
###  CONFIGURATION END  ###
###########################

# Input arguments check
if [ $# -ne 1 ] && [ $# -ne 2 ]; then
	echo "Usage:"
	echo "sh $0 --root (to generate the root certificate)"
	echo "sh $0 <certificate_name> <host> (to generate a derivated certificate)"
	exit 0
fi

# Retrieving input arguments
name=$1
host=$2

# Checking if the root certificate only has to be created
if [ "$name" == "--root" ]; then
	name=root
fi

# Opening the output directory
mkdir certs 2> /dev/null
cd certs

# Create a new SSL key
#openssl genrsa -aes256 -out $name.key $BITS
openssl genrsa -out $name.key $BITS

# Creating certificate subject data
SUBJECTDATA="/C=${DATA_COUNTRYCODE}/ST=${DATA_COUNTRY}/L=${DATA_LOCATION}/O=${DATA_ORGANIZATION}/emailAddress=${DATA_EMAIL}"

# Terminating the program, if the root certificate only has to be created
if [ "$name" == "root" ]; then
	openssl req -new -x509 -key root.key -out root.cer -days $DAYS -sha256 -subj "$SUBJECTDATA"
	# Checking if everything is ok
	C=`openssl x509 -text < certs/root.cer|grep "CA:TRUE"|wc -l|awk '{print $1}'`
	if [ $C -le 0 ]; then
		echo "Root certificate generation failed"
	fi
	exit 1
fi

# Adding host information to subject data
SUBJECTDATA="${SUBJECTDATA}/CN=$host"

# Use that key to generate a request
openssl req -new -key $name.key -out $name.req -subj "$SUBJECTDATA"

# Sign that request to generate a new cert
openssl x509 -req -in $name.req -out $name.cer -CA root.cer -CAkey root.key  -sha256 -CAcreateserial

# Going back to main directory
cd ..

exit 2
