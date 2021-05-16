from PIL import Image
import json

def lambda_handler(event, context):   
    # UPDATE
    returnStr = {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
    print(returnStr)
    return returnStr

if __name__ == "__main__":
    # __MAIN__ CONTROLLER TO RUN LAMBDA_HANDLER LOCALLY
    lambda_handler('', '')