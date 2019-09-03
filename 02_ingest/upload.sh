#!/bin/bash
export BUCKET=${BUCKET:=dsci_prac_test_dh_1}
echo "Uploading to bucket $BUCKET..."
gsutil -m cp *.csv gs://$BUCKET/flights/raw
#gsutil -m acl ch -R -g google.com:R gs://$BUCKET/flights/raw
