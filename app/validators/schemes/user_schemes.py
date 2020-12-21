from datetime import datetime
from pydantic import BaseModel
from typing import Optional


# TODO: make foreign keys?
class UserScheme(BaseModel):
    email: str
    password: str