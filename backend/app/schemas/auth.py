"""
Authentication schemas.
"""
from typing import Optional

from pydantic import BaseModel


class Token(BaseModel):
    """Token response schema."""
    access_token: str
    token_type: str
    expires_in: int


class TokenData(BaseModel):
    """Token data schema."""
    email: Optional[str] = None


class LoginRequest(BaseModel):
    """Login request schema."""
    email: str
    password: str


class PasswordResetRequest(BaseModel):
    """Password reset request schema."""
    email: str


class PasswordResetConfirm(BaseModel):
    """Password reset confirmation schema."""
    token: str
    new_password: str 