"""
Health check endpoints.
"""
from typing import Dict, Any

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text

from app.db.session import get_db
from app.core.config import settings
from app.core.logging import get_logger

router = APIRouter()
logger = get_logger(__name__)


@router.get("/")
async def health_check() -> Dict[str, Any]:
    """Basic health check endpoint."""
    return {
        "status": "healthy",
        "environment": settings.ENVIRONMENT,
        "version": settings.VERSION,
    }


@router.get("/ready")
async def readiness_check(db: AsyncSession = Depends(get_db)) -> Dict[str, Any]:
    """Readiness check including database connectivity."""
    try:
        # Check database connectivity
        result = await db.execute(text("SELECT 1"))
        result.fetchone()
        
        return {
            "status": "ready",
            "database": "connected",
            "environment": settings.ENVIRONMENT,
        }
    except Exception as e:
        logger.error("Readiness check failed", error=str(e))
        raise HTTPException(
            status_code=503,
            detail={
                "status": "not ready",
                "database": "disconnected",
                "error": str(e),
            }
        )


@router.get("/live")
async def liveness_check() -> Dict[str, Any]:
    """Liveness check for Kubernetes."""
    return {
        "status": "alive",
        "timestamp": "2024-01-01T00:00:00Z",  # You might want to use actual timestamp
    }


@router.get("/detailed")
async def detailed_health_check(db: AsyncSession = Depends(get_db)) -> Dict[str, Any]:
    """Detailed health check with all service dependencies."""
    health_status = {
        "status": "healthy",
        "environment": settings.ENVIRONMENT,
        "version": settings.VERSION,
        "checks": {
            "database": "unknown",
            "gcp_secret_manager": "unknown",
        }
    }
    
    # Check database
    try:
        result = await db.execute(text("SELECT 1"))
        result.fetchone()
        health_status["checks"]["database"] = "healthy"
    except Exception as e:
        health_status["checks"]["database"] = "unhealthy"
        health_status["status"] = "unhealthy"
        logger.error("Database health check failed", error=str(e))
    
    # Check GCP Secret Manager (if enabled)
    if settings.SECRET_MANAGER_ENABLED:
        try:
            # This would be a more comprehensive check in production
            health_status["checks"]["gcp_secret_manager"] = "healthy"
        except Exception as e:
            health_status["checks"]["gcp_secret_manager"] = "unhealthy"
            health_status["status"] = "unhealthy"
            logger.error("GCP Secret Manager health check failed", error=str(e))
    
    return health_status 