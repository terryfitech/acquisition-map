"""Health and readiness routes."""

from fastapi import APIRouter

router = APIRouter(tags=["system"])


@router.get("/health")
async def health() -> dict[str, str]:
    """Return a minimal process health response."""
    return {"status": "ok", "service": "acquisition-map-api"}
