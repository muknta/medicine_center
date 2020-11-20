from datetime import datetime
from pydantic import BaseModel
from typing import Optional


# TODO: make foreign keys?
class LoginScheme(BaseModel):
    email: str
    password: str
