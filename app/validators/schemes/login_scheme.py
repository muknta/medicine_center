from pydantic import BaseModel


# TODO: make foreign keys?
class LoginScheme(BaseModel):
    email: str
    password: str

