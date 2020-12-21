import shutil
import os
import uuid

from fastapi import APIRouter, File, UploadFile
from starlette.responses import FileResponse

from app.validators.schemes.disease_history_scheme import DiseaseHistoryScheme
from app.disease_storage.upload_file import FileUploader
from app.database.disease_history import HistoriesCollection
from app.api.repository import Repository
from config import CLEARED_DIR

router = APIRouter()


@router.get('/{patient_id}')
async def get_disease_histories(patient_id: str):
    """
    Get list of disease histories of some user
    :param patient_id:
    :return: list of histtories
    """
    histories_patient = Repository.get_histories_by_patient_id(patient_id)

    return {'data': histories_patient, 'result': bool(histories_patient)}


@router.get('/read_history/{history_id}')
async def get_history(history_id: str):
    """
    Get history of some patient with some id of history
    :param history_id: id of history in the database
    :return: histories with history_id
    """
    history = Repository.get_history_by_id(history_id)

    return {'data': history, 'result': bool(history)}


@router.post('/disease_history/add')
async def add_history(history: DiseaseHistoryScheme):
    """
    Add to database new disease history for user
    :param history: dict of data to add to database
    :return:
    """
    Repository.add_history(history)

    return {'description': 'Success add', 'result': True}


@router.put('/disease_history/update/{history_id}')
async def update_history(history_id: str, history: DiseaseHistoryScheme):
    """
    Update history with id - history_id
    :param history_id: id of history in the database
    :param history: dict of data to add to database
    :return:
    """
    result, status = Repository.update_history(history_id, history)

    return {'description': result, 'result': status}


@router.delete('/disease_history/delete/{history_id}')
async def delete_history(history_id: str):
    """
    Delete history with id - history_id
    :param history_id: id of history in the database
    :return:
    """
    result, status = Repository.delete_history(history_id)

    return {'description': result, 'result': status}


@router.post("/uploadfile/{history_id}")
async def upload_file(history_id: str, file: UploadFile = File(...)):
    """
    upload file to google cloud storage
    :param history_id: id of history in the database
    :param file: file to uploading
    :return:
    """
    if history_id in HistoriesCollection.get_ids():
        if not Repository.get_history_by_id(history_id).get('file_name'):
            with open(file.filename, "wb") as buffer:
                shutil.copyfileobj(file.file, buffer)

            new_filename = str(uuid.uuid4()) + '.' + file.filename.split('.')[-1]
            os.renames(file.filename, new_filename)
            shutil.move(new_filename, "app/disease_storage/")

            file_uploader = FileUploader()
            file_uploader.upload_file('app/disease_storage/' + new_filename, new_filename)

            Repository.update_history(history_id, {'file_name': new_filename})

            return {'description': 'Success add file', 'result': True}
        else:
            return {'description': 'File already added', 'result': False}

    return {'description': 'Can\'n found history by this id', 'result': False}


@router.get("/download/{history_id}")
async def download_file(history_id: str):
    if history_id in HistoriesCollection.get_ids():
        filename = Repository.get_history_by_id(history_id).get('file_name')

        if filename not in os.listdir(CLEARED_DIR):
            file_uploader = FileUploader()

            if filename in file_uploader.list_blobs():
                file_uploader.download_file(filename)
            else:
                return {'description': "File not found", 'result': True}

            shutil.move(filename, "app/disease_storage/")

        return FileResponse('app/disease_storage/' + filename, media_type='application/octet-stream', filename=filename)

    return {'description': 'Can\'n found history by this id', 'result': False}


@router.delete('/file/delete/{history_id}')
async def delete_file(history_id: str):
    filename = Repository.get_history_by_id(history_id).get('file_name')

    if filename:
        file_uploader = FileUploader()

        if filename in file_uploader.list_blobs():
            file_uploader.delete_file(filename)
        else:
            Repository.update_history(history_id, {'file_name': None})
            return {"description": "File not found", 'result': False}

        Repository.update_history(history_id, {'file_name': None})
        return {"description": "File was successful deleted", 'result': True}

    return {"description": "File not found", 'result': False}
