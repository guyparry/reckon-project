"""
Logging configuration for the application.
"""
import logging
import sys
from typing import Any, Dict

import structlog
from google.cloud import logging as cloud_logging
from structlog.stdlib import LoggerFactory

from app.core.config import settings


def setup_logging() -> None:
    """Setup structured logging with GCP integration."""
    
    # Configure structlog
    structlog.configure(
        processors=[
            structlog.stdlib.filter_by_level,
            structlog.stdlib.add_logger_name,
            structlog.stdlib.add_log_level,
            structlog.stdlib.PositionalArgumentsFormatter(),
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.processors.StackInfoRenderer(),
            structlog.processors.format_exc_info,
            structlog.processors.UnicodeDecoder(),
            structlog.processors.JSONRenderer() if settings.LOG_FORMAT == "json" else structlog.dev.ConsoleRenderer(),
        ],
        context_class=dict,
        logger_factory=LoggerFactory(),
        wrapper_class=structlog.stdlib.BoundLogger,
        cache_logger_on_first_use=True,
    )
    
    # Configure standard library logging
    logging.basicConfig(
        format="%(message)s",
        stream=sys.stdout,
        level=getattr(logging, settings.LOG_LEVEL.upper()),
    )
    
    # Setup GCP logging if in cloud environment
    if settings.ENVIRONMENT == "production":
        try:
            client = cloud_logging.Client()
            client.setup_logging()
        except Exception as e:
            logger = structlog.get_logger()
            logger.warning("Failed to setup GCP logging", error=str(e))


def get_logger(name: str = __name__) -> structlog.BoundLogger:
    """Get a structured logger instance."""
    return structlog.get_logger(name)


# Create a default logger
logger = get_logger()


class RequestLoggingMiddleware:
    """Middleware to log HTTP requests."""
    
    def __init__(self, app):
        self.app = app
        self.logger = get_logger("http")
    
    async def __call__(self, scope, receive, send):
        if scope["type"] == "http":
            # Log request
            self.logger.info(
                "Request started",
                method=scope["method"],
                path=scope["path"],
                query_string=scope["query_string"].decode(),
                client=scope.get("client"),
            )
            
            # Create a custom send function to log response
            async def send_wrapper(message):
                if message["type"] == "http.response.start":
                    self.logger.info(
                        "Request completed",
                        method=scope["method"],
                        path=scope["path"],
                        status_code=message["status"],
                    )
                await send(message)
            
            await self.app(scope, receive, send_wrapper)
        else:
            await self.app(scope, receive, send)


def log_request_info(request_info: Dict[str, Any]) -> None:
    """Log request information."""
    logger.info("Request processed", **request_info)


def log_error(error: Exception, context: Dict[str, Any] = None) -> None:
    """Log error with context."""
    logger.error(
        "Application error",
        error_type=type(error).__name__,
        error_message=str(error),
        context=context or {},
        exc_info=True,
    ) 