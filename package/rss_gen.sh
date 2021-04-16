#!/bin/bash

# 3390075e-3b0d-48c6-a788-d8fb7a3d0116
archive_id=$1;
region="us-east-1";
collection_table_name="Collection-xya5men6drayjivi24pf5rrk7i-pod";
archive_table_name="Archive-xya5men6drayjivi24pf5rrk7i-pod";

REGION=$region COLLECTION_TABLE_NAME=$collection_table_name ARCHIVE_TABLE_NAME=$archive_table_name ARCHIVE_ID=$archive_id python3 lambda_function.py