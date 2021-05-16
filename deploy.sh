#!/usr/bin/env bash
# When execute 'lambda_function.py' will be archived and the resulting zip published to AWS lambda under FUNCTION_NAME
FUNCTION_NAME="lambda-image-processing"
FUNCTION_ROLE="arn:aws:iam::161721781481:role/lambda-ex"  # << UPDATE TO YOUR ROLE ARN
AWS_CLI_PROFILE="home"          # << UPDATE TO YOUR PROFILE NAME, OR SET TO "default"

# ZIP THE FUNCTION
zip my-deployment-package.zip lambda_function.py

# EITHER CREATE THE FUNCTION IN AWS
printf "\n |-----------------------------------------------------------------------------| \n "
printf "|          SEARCHING FOR CREATED FUNCTION:   $FUNCTION_NAME          | \n "
printf "|-----------------------------------------------------------------------------| \n "
if ! aws lambda list-functions --profile $AWS_CLI_PROFILE | grep '"FunctionName": "'$FUNCTION_NAME ; then
    aws lambda create-function \ 
        --function-name $FUNCTION_NAME  \
        --zip-file fileb://my-deployment-package.zip \ 
        --runtime python3.8 \ 
        --role $FUNCTION_ROLE \ 
        --profile $AWS_CLI_PROFILE
    printf "\n |-----------------------------------------------------------------------------| \n "
    printf "|          FUNCTION CREATED:         $FUNCTION_NAME                     | \n "
    printf "|-----------------------------------------------------------------------------| \n "
    printf "\n"
    exit
fi

# OR UPDATE THE EXISTING FUNCTION IN AWS
aws lambda update-function-code \
    --function-name $FUNCTION_NAME  \
    --zip-file fileb://my-deployment-package.zip \
    --profile $AWS_CLI_PROFILE

printf "\n |-----------------------------------------------------------------------------| \n "
printf "|          FUNCTION UPDATED:         $FUNCTION_NAME                  | \n "
printf "|-----------------------------------------------------------------------------| \n "
printf "\n"
