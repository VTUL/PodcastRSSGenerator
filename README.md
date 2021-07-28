# Podcast RSS Generator
An AWS stack that creates lambda function to generate an up to date RSS feed document whenever a new podcast episode is deposited into the [VT Digital Library Platform](https://github.com/VTUL/dlp-access). 


## Techniques
* The generated lambda function is triggered when a new record is created in the DynamoDB Archive table that is specified in the deployment.
* The lambda function checks if the new record is in the "podcasts" item category. The script will only continue if it is a podcast record.
* The lambda function generates the RSS feed info for the podcast collection that the new podcast episode belongs to and writes this info to the s3 bucket specified in the deployment

## Deployment

You can use two different methods to deploy VTDLP Services. The first method is using CloudFormation stack and the second method is using SAM CLI.

### Deploy VTDLP Services using CloudFormation stack
#### Step 1: Launch CloudFormation stack
[![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?&templateURL=https://vtdlp-lee-test.s3.amazonaws.com/feca98996d1db2568271f8c7b34a200d.template)

Click *Next* to continue

#### Step 2: Specify stack details

* <b>Stack name</b>: Stack name can include letters (A-Z and a-z), numbers (0-9), and dashes (-).

* <b>Parameters</b>: Parameters are defined in your template and allow you to input custom values when you create or update a stack.

| Name | Description | Note |
|:---  |:------------|:------------|
| ArchiveStream | a DynamoDB Archive table stream name. This is the value following the final backslash in `Latest stream ARN` under "DynamoDB stream details". Example: `2020-09-18T16:55:17.247` | **Required** |
| ArchiveTable | a DynamoDB table name of type Archive | **Required** |
| BucketName | A valid S3 bucket name | **Required** |
| CollectionTable | a DynamoDB table name of type Collection | **Required** |
| Region | a valid AWS region. e.g. us-east-1  | **Required** |

#### Step 3: Configure stack options
Leave it as is and click **Next**

#### Step 4: Review
Make sure all checkboxes under Capabilities section are **CHECKED**

Click *Create stack*

#### Step 5: Finish
After cloudformation is deployed successfully, you can see `podcastRSSGenerator`, `podcastRSSGeneratorRole`, and `podcastRSSGeneratorStream` information in the `Resources` tab.



### Deploy the app using AWS CLI

To use the SAM CLI, you need the following tools.

* SAM CLI - [Install the SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
* [Python 3 installed](https://www.python.org/downloads/)
* Docker - [Install Docker community edition](https://hub.docker.com/search/?type=edition&offering=community)

To build and deploy your application for the first time, run the following in your shell:

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
Above command will build the source of the application. The SAM CLI installs dependencies defined in `requirements.txt`, creates a deployment package, and saves it in the `.aws-sam/build` folder.

* Package the project for deployment
```sh
sam package \
  --template-file template.yml \
  --output-template-file package.yml \
  --s3-bucket YOUR_S3_BUCKET_NAME
```    
Above command will package the application and upload it to the S3 bucket you specified.

* Deploy the project to AWS   
```sh
sam deploy --template-file packaged.yaml --stack-name YOUR_STACK_NAME --s3-bucket YOUR_S3_BUCKET_NAME --parameter-overrides 'Region=us-YOUR_REGION CollectionTable=YOUR_DYNAMODB_COLLECTION_TABLE_NAME ArchiveTable=YOUR_DYNAMODB_ARCHIVE_TABLE_NAME ArchiveStream=YOUR_ARCHIVE_STREAM BucketName=YOUR_S3_BUCKET_NAME' --capabilities CAPABILITY_IAM --region YOUR_REGION
```    
The above command will package and deploy your application to AWS, with a series of prompts:

- **Stack Name** (STACKNAME): (Required) The name of the AWS CloudFormation stack that you're deploying to. If you specify an existing stack, the command updates the stack. If you specify a new stack, the command creates it. This should be unique to your account and region, and a good starting point would be something matching your project name. Stack name can include letters (A-Z and a-z), numbers (0-9), and dashes (-).
- **S3 Bucket** (BUCKETNAME): (Required) An Amazon S3 bucket name where this command uploads your AWS CloudFormation template. S3 bucket name is globally unique, and the namespace is shared by all AWS accounts. See [Bucket naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html). This S3 bucket should be already exist and you have the permission to upload files to it.
- **Parameter Overrides**: A string that contains AWS CloudFormation parameter overrides encoded as key-value pairs. For example, ParameterKey=ParameterValue NSTableName=DDBTableName.
  | Name | Description | Note |
  |:---  |:------------|:------------|
  | ArchiveStream | a DynamoDB Archive table stream name. This is the value following the final backslash in `Latest stream ARN` under "DynamoDB stream details". Example: `2020-09-18T16:55:17.247` | **Required** |
  | ArchiveTable | a DynamoDB table name of type Archive | **Required** |
  | BucketName | A valid S3 bucket name | **Required** |
  | CollectionTable | a DynamoDB table name of type Collection | **Required** |
  | Region | a valid AWS region. e.g. us-east-1  | **Required** |



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