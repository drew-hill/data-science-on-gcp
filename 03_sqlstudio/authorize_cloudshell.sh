#!/bin/bash
gcloud sql instances patch flights1 \
    --authorized-networks `wget -qO - http://ipecho.net/plain`/32
