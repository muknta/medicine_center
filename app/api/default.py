from fastapi.params import Depends
from fastapi_jwt_auth import AuthJWT
from starlette.responses import FileResponse
from pydantic import ValidationError
from datetime import datetime

from app.validators.schemes.login_scheme import LoginScheme
from app.validators.schemes.patient_create_scheme import RegisterScheme
from app.database.users import UsersCollection
from app.api.repository import Repository
from app.main import app
from fastapi import APIRouter

from config import DEBUG_LOGIN

router = APIRouter()


@router.get('/')
def init():
    return FileResponse('./static/index.html')


@router.post('/register')
def register(user: RegisterScheme):
    # TODO: Unique email
    try:
        registered_user = Repository.add_user({
            "email": user.email,
            "password": UsersCollection.get_password_hash(user.password1),
            "name": user.name,
            "surname": user.surname,
            "patronymic": user.patronymic,
            "phone_number": user.phone_number,
            "gender": user.gender,
            "address": user.address,
            "profession": user.profession,
            "birthday": UsersCollection.date_to_datetime(user.birthday),
            "role": 'patient'
        })
    except ValidationError as e:
        return {"result": False, "msg": e}

    if registered_user:
        if registered_user['role'] == 'patient':
            try:
                Repository.add_patient({
                    "user_id": str(registered_user['_id']),
                    "address": registered_user['address'],
                    "profession": registered_user['profession']
                })
            except ValidationError as e:
                return {"result": False, "msg": e}
        return {"result": True, 'user_id': str(registered_user['_id']),
            'email': registered_user['email'], 'role': registered_user['role'],
            'profession': registered_user['profession'], 'name': registered_user['name'],
            'surname': registered_user['surname'], 'patronymic': registered_user['patronymic'],
            'address': registered_user['address'], 'gender': registered_user['gender'],
            'phone_number': registered_user['phone_number'], 'birthday': registered_user['birthday']}
    return {"result": False, "msg": "Invalid credentials"}

@router.post('/login')
def login(user: LoginScheme, Authorize: AuthJWT = Depends()):
    registered_user = UsersCollection.get_one_obj({"email": user.email})
    if registered_user:
        password_correct = UsersCollection.verify_password(user.password, registered_user['password'])
        if password_correct:
            access_token = Authorize.create_access_token(subject=registered_user['email'])
            refresh_token = Authorize.create_refresh_token(subject=registered_user['email'])
            if not DEBUG_LOGIN:
                app.state.redis.save_tokens(Authorize.get_jti(access_token), Authorize.get_jti(refresh_token))
            return {"access_token": access_token, "refresh_token": refresh_token, "result": True,
                    "user_id": str(registered_user["_id"]), "role": registered_user["role"]}
    return {"result": False, "msg": "Invalid credentials"}


@router.get('/logout')
async def logout(Authorize: AuthJWT = Depends()):
    Authorize.jwt_required()
    app.state.redis.revoke_tokens(Authorize.get_raw_jwt()['jti'])
    return {"status": "ok", "msg": "logged out", "result": True}


# EXAMPLE OF PROTECTED ROUTE

@router.get('/protected')
def protected(Authorize: AuthJWT = Depends()):
    Authorize.jwt_required()
    current_user = Authorize.get_jwt_subject()
    return {"status": "ok", "msg": f"current_user: {current_user}"}
