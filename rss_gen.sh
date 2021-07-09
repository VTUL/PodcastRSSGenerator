#!/bin/bash

archive_id=$1;
region="us-east-1";
collection_table_name="Collection-platn5bmyzfuxh3y64q65xe3xi-newdev";
archive_table_name="Archive-platn5bmyzfuxh3y64q65xe3xi-newdev";
bucket_name="vtdlp-lee-test";

REGION=$region COLLECTION_TABLE_NAME=$collection_table_name ARCHIVE_TABLE_NAME=$archive_table_name ARCHIVE_ID=$archive_id BUCKET_NAME=$bucket_name python3 lambda_function.py

