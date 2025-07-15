"""
User schemas.
"""
from typing import Optional
from datetime import datetime

from pydantic import BaseModel, EmailStr


class UserBase(BaseModel):
    """Base user schema."""
    email: Optional[EmailStr] = None
    is_active: Optional[bool] = True
    is_superuser: bool = False
    full_name: Optional[str] = None


class UserCreate(UserBase):
    """User creation schema."""
    email: EmailStr
    password: str


class UserUpdate(UserBase):
    """User update schema."""
    password: Optional[str] = None


class UserInDBBase(UserBase):
    """User in database base schema."""
    id: Optional[int] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class User(UserInDBBase):
    """User schema for API responses."""
    pass


class UserInDB(UserInDBBase):
    """User in database schema."""
    hashed_password: str 