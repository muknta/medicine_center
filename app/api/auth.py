from fastapi import APIRouter, Depends
from fastapi_jwt_auth import AuthJWT

from app.main import app
from config import DEBUG_LOGIN

router = APIRouter()


@router.get('/refresh')
async def refresh_tokens(Authorize: AuthJWT = Depends()):
    Authorize.jwt_refresh_token_required()
    current_user = Authorize.get_jwt_subject()

    jti = Authorize.get_raw_jwt()['jti']

    access_token = Authorize.create_access_token(subject=current_user)
    refresh_token = Authorize.create_refresh_token(subject=current_user)

    if not DEBUG_LOGIN:
        app.state.redis.revoke_tokens(jti)
        app.state.redis.save_tokens(Authorize.get_jti(access_token), Authorize.get_jti(refresh_token))

    return {"access_token": access_token, "refresh_token": refresh_token, "result": True}

