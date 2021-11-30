# codegreen-awsreinvent-2021

# DESCRIPTION:
    The application pulls data from usage of compute, storage resources from the cloud provider and stores it in DynamoDB. 
     
    Here, we used the ASDI (Amazon Sustainability Data Initiative) and AWS Data Exchange (ADX) to refer the dataset for comparsion and reference. In this scenario, we have used the dataset from Thoughtworks named "Cloud Carbon Coefficients".

    Once subscribed to a data product, use the AWS Data Exchange API to load data directly into Amazon S3 and then analyzed it with a ATHENA and Quicksight services.

# Architecture Diagram


# STEP 
- Subscribe to the ASDI dataset using ADX.
- It imports the data to S3 bucket with same dataset name
- Lambda function to perform data cleansing and transformation and store to destination S3 bucket ( In Progress )
- Create Table for clean and transformed dataset in ATHENA using Glue Crawler or manually using the SQL query. 
- Explore the dataset by querying the data in ATHENA.
- Used Quicksight for observation and visualization of Data.


# Well Architected Framework Consideration:

- Consider S3 Lifecycle for transition of data to Glacier/IA
- Consider using spice in Quicksight because the carbon emission value are static and change only quarterly.
- Used Serverless technology (AWS services) to make it cost efficient, scalable and reliable.
- Consider encryption, least prviliages and private subnet for compute and DB for security.
 

