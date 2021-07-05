import boto3
from urllib.parse import unquote_plus
from PIL import Image

s3_client = boto3.client('s3')
UPLOAD_BUCKET = 'lambda-image-upload'  # <-- Update with your own bucket id


def resize_image(image_path, resized_path):
    # Resize image from image_path and save to resized_path
    with Image.open(image_path) as image:
        image.thumbnail(tuple(x / 2 for x in image.size))
        image.save(resized_path)


def lambda_handler(event, context):
    for record in event['Records']:
        # Fetch bucket and object key (absolute path) and image.
        source_bucket = record['s3']['bucket']['name']
        key = unquote_plus(record['s3']['object']['key'])
        image = key.split('/')[-1]

        # Establish variables tmp images, download, resize + upload
        download_path = '/tmp/{}'.format(image)
        upload_path = '/tmp/resized-{}'.format(image)
        s3_client.download_file(source_bucket, key, download_path)
        resize_image(download_path, upload_path)
        s3_client.upload_file(upload_path, UPLOAD_BUCKET,
                              'processed/{}'.format(image))


if __name__ == "__main__":
    # __MAIN__ CONTROLLER TO RUN LAMBDA_HANDLER LOCALLY, ensure all variables are updated in line with your AWS account
    event = {"Records": [{"eventName": "ObjectCreated:Put", "s3": {"bucket": {
        "name": "lambda-image-processing"}, "object": {"key": "preprocessing/image.jpg"}}}]}
    lambda_handler(event, '')
