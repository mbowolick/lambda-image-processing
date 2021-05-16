# lambda-image-processing

lambda-image-processing is a small python project created to resize S3 images and upload to a target bucket using the Python package [Pillow](https://pillow.readthedocs.io/en/stable/installation.html). Pillow should be setup as a Lambda Runtime Layer for this to work (compatibililty can get a bit tricky, follow steps below).

### Prerequisites:
1. AWS CLI v2 is configured with your AWS CLI KEYS
2. Awareness of Lambda and Lambda Runtime Layers
3. Python3.8 is installed locally (you can install specific versions with brew)
    ```bash
    $ brew search python@3.8
    ==> Formulae
    python@3.8 ✔
    ```
    ```bash
    $ python3 --version
    Python 3.8.4
    ```
4. You Lambda Execution Role is created

## Local Installation

### Step 1

Move inside in the root directory of the application:
```
./lambda-image-processing/       // <-- ROOT directory
├── README.md
├── deploy.sh
├── lambda_function.py
├── requirements.txt
├── setup.sh
├── tmp
│   └── image.jpg
```

### Step 2

Run setup.sh: this creates a virtual environment, activate the environment and use the package manager [pip3](https://pip.pypa.io/en/stable/) to install the requirements.txt.

```bash
./setup.sh
```

### Step 3
Run virtual environment 'activate': 
```bash
. venv/bin/activate
```

### Step 4 Usage
Simply run the main project and obverse the results:
```bash
python3 ./lambda_function.py
```

## Lambda Installation (with PILLOW Layer Setup)

### Step 1

Edit deploy.sh with your corresponding: FUNCTION_NAME, FUNCTION_ROLE ARN and AWS_CLI_PROFILE. Note: for AWS_CLI_PROFILE you can set to "default" if you are not using profiles. 

### Step 2

Run deploy.sh: this creates packages the lambda_function.py program and deploys to AWS Lambda. If the function exists it is updated, if the function doesn't exist yet it creates it.  
```bash
./deploy.sh
```
### Step 3

Log into the AWS Console and navigate to Lambda and edit your function. Scroll down and within the Layers section click "Add a Layer". 

### Step 4

Select Layer Source as "Specify an ARN" and provide your corresponding regions ARN for PILLOW (or you can upload your custom Layer through ZIP or S3). I leveraged the following [Keith's Layers (Klayers) for Python3.8](https://github.com/keithrozario/Klayers/tree/master/deployments/python3.8/arns).

For example for example 'ap-southeast-2.csv':
```
arn:aws:lambda:ap-southeast-2:770693421928:layer:Klayers-python38-Pillow:10
```

### Step 5

Test away! :)