## Set env variables:
   * MONGODB_PASSWORD = <MONGODB_PASSWORD>

## Install:
   * git clone https://github.com/NazarKostetskiy/medicine_center
   * cd medicine_center
   * pipenv install
   * change baseUrl in config.dart in frontend directory to yours and build flutter project
   * ##### Setup storage file:
        * <a href="https://console.cloud.google.com/cloud-resource-manager">Select or create a Cloud Platform project</a>
        * <a href="https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project">Enable billing for your project</a>
        * <a href="https://cloud.google.com/storage">Enable the Google Cloud Storage API</a>
        * Create new bucket
            * Select in the navigation menu "Storage"
            * In new page select "Create Bucket" 
            * Setup following instruction and your finance and put "Create". In the result you create bucket for storage files
            * In config.py file replace in this constant on your bucket name or you can name your bucket 'disease-history-files' and not to change
            ```DISEASE_HISTORY_FILES_NAME = <BUCKET_NAME>```
        * Download Service Account Key (This file include the information related to the project)
            * Select in the navigation menu "APIs & Services" -> Credential
            * In new page select "Create Credentials" -> "Service Account"
            * Setup your service account and put "Create"
            * In the list of credential -> service accounts select created account
            * Select "Add Key" -> "Create new key"
            * In the modal box select "JSON" Key type and put "Create"
        * Move downloaded file to start direction of the project (near main.py)
        * Rename the file on "keys_service_account.json" or you can change on your file in the config.py
        ```JSON_KEYS_SERVICE_ACCOUNT = os.path.join(BASE_DIR, <FILE_NAME>)```

## Docker
   ### Build:
      * sudo docker build -t medicine_center .
   ### Run container:
      * docker run --env MONGODB_PASSWORD=$MONGODB_PASSWORD -d --name medicine_center -p 80:80 medicine_center

## Docker compose
   ### Build and up:
      * sudo docker-compose -f "docker-compose.yml" up -d --build
   ### Down:
      * sudo docker-compose -f "docker-compose.yml" down

## Run server:
   * pipenv run uvicorn run:app
   * pipenv run uvicorn run:chat 
## DEBUG:
   * http://127.0.0.1:8000/docs

