from pydantic import BaseModel


class LoginScheme(BaseModel):
    email: str
    password: str
