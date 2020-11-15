import os
from datetime import timedelta
from pathlib import Path
from pydantic import BaseModel

BASE_DIR = Path(__file__).resolve().parent

DEBUG_LOGIN = True

DB_PASSWORD = os.environ['MONGODB_PASSWORD']
DATABASE_NAME = 'med'
DB_SOURCE = f'mongodb+srv://user:{DB_PASSWORD}@cluster.7pk1k.mongodb.net/{DATABASE_NAME}?retryWrites=true&w=majority'
ADMIN_EXPIRES_DELTA = timedelta(minutes=5)

ACCESS_EXPIRES_DELTA = timedelta(minutes=5)
REFRESH_EXPIRES_DELTA = timedelta(hours=2)


JWT_SECRET = 'medsecret'


class JwtSettings(BaseModel):
    authjwt_secret_key: str = JWT_SECRET
    if not DEBUG_LOGIN:
        authjwt_denylist_enabled: bool = True
    authjwt_header_type: str = 'Authorization-Token'
    authjwt_access_token_expires = ACCESS_EXPIRES_DELTA
    authjwt_refresh_token_expires = REFRESH_EXPIRES_DELTA


JSON_KEYS_SERVICE_ACCOUNT = os.path.join(BASE_DIR, 'keys_service_account.json')
DISEASE_HISTORY_FILES_NAME = 'disease-history-files'
