#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: ./populate_table.sh  bucket-name"
    exit
fi

BUCKET=$1
echo "Populating Cloud SQL instance flights1 from gs://${BUCKET}/flights1/raw/..."

# To run mysqlimport and mysql, authorize CloudShell
bash authorize_cloudshell.sh

# the table name for mysqlimport comes from the filename, so rename our CSV files, changing bucket name as needed
counter=0
#for FILE in $(gsutil ls gs://${BUCKET}/flights1/raw/2015*.csv); do
#   gsutil cp $FILE flights1.csv-${counter}
for FILE in 201501.csv 201507.csv; do
   gsutil cp gs://${BUCKET}/flights1/raw/$FILE flights1.csv-${counter}
   counter=$((counter+1))
done

# import csv files
MYSQLIP=$(gcloud sql instances describe flights1 --format="value(ipAddresses.ipAddress)")
mysqlimport --local --host=$MYSQLIP --user=root --ignore-lines=1 --fields-terminated-by=',' --password bts flights1.csv-*
rm flights1.csv-* 

