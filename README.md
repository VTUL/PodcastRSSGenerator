# Podcast RSS Generator
An AWS stack that creates lambda function to generate an up to date RSS feed document whenever a new podcast episode is deposited into the [VT Digital Library Platform](https://github.com/VTUL/dlp-access). 


## Techniques
* The generated lambda function is triggered when a new record is created in the DynamoDB Archive table that is specified in the deployment.
* The lambda function checks if the new record is in the "podcasts" item category. The script will only continue if it is a podcast record.
* The lambda function generates the RSS feed info for the podcast collection that the new podcast episode belongs to and writes this info to the s3 bucket specified in the deployment

## Requirements
The following must be installed on your local system:
* [AWS SAM](https://aws.amazon.com/serverless/sam/)
* [Docker desktop](https://www.docker.com/products/docker-desktop)
* [make](https://www.gnu.org/software/make/)

## Deployment

### Deploy the app using AWS CLI
* Clone the repo to your local system
```sh
git clone https://github.com/VTUL/PodcastRSSGenerator.git
```

* From the root of the repository run the Makefile to install python dependencies
```sh
cd path/to/PodcastRSSGenerator/
make
```

* Build the project
```sh
sam build --use-container
```

* Package the project for deployment
```sh
sam package \
  --template-file template.yml \
  --output-template-file package.yml \
  --s3-bucket YOUR_S3_BUCKET_NAME
```

* Deploy the project to AWS
NOTES:
  * Stack will be created. `YOUR_STACK_NAME` does not need to be an existing stack.
  * `YOUR_ARCHIVE_STREAM` should be the final part of the stream ARN. example: `2020-09-18T16:55:17.247`
```sh
sam deploy --template-file packaged.yaml --stack-name YOUR_STACK_NAME --s3-bucket YOUR_S3_BUCKET_NAME --parameter-overrides 'Region=us-YOUR_REGION CollectionTable=YOUR_DYNAMODB_COLLECTION_TABLE_NAME ArchiveTable=YOUR_DYNAMODB_ARCHIVE_TABLE_NAME ArchiveStream=YOUR_ARCHIVE_STREAM BucketName=YOUR_S3_BUCKET_NAME' --capabilities CAPABILITY_IAM --region YOUR_REGION
```

## Cleanup
If you'd like to tear down the project & delete all of the resources created by this project, you can run the following:
```sh
aws cloudformation delete-stack --stack-name YOUR_STACK_NAME
```

## Communication
* GitHub issues: bug reports, feature requests, install issues, thoughts, etc.
* Email: digital-libraries@vt.edu

## Releases and Contributing
We have a 30 day release cycle (We do Sprints!). Please let us know if you encounter a bug by filing an issue. We appreciate all contributions.

If you are planning to contribute back bug-fixes, please do so without any further discussion. 

If you plan to contribute new features, utility functions or extensions to the core, please first open an issue and discuss the feature with us.

To learn more about making a contribution, please see our [Contribution page](CONTRIBUTING.md).

## The Team
DLP Access Website is currently maintained by [Yinlin Chen](https://github.com/yinlinchen), [Lee Hunter](https://github.com/whunter), and [Andrea Waldren](https://github.com/andreaWaldren).