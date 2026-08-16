"""FastAPI application composition."""

from fastapi import FastAPI

from acquisition_map.api.routes.health import router as health_router
from acquisition_map.security.headers import SecurityHeadersMiddleware

app = FastAPI(
    title="Acquisition Map API",
    version="0.1.0",
    docs_url=None,
    redoc_url=None,
)
app.add_middleware(SecurityHeadersMiddleware)
app.include_router(health_router)
