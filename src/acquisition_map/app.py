"""FastAPI application composition."""

from fastapi import FastAPI

from acquisition_map.api.routes.health import router as health_router

app = FastAPI(
    title="Acquisition Map API",
    version="0.1.0",
    docs_url=None,
    redoc_url=None,
)
app.include_router(health_router)
