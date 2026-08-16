from fastapi.testclient import TestClient

from acquisition_map.app import app


def test_health_response_has_baseline_security_headers() -> None:
    client = TestClient(app)

    response = client.get("/health")

    assert response.headers["x-content-type-options"] == "nosniff"
    assert response.headers["x-frame-options"] == "DENY"
    assert response.headers["referrer-policy"] == "no-referrer"
    assert response.headers["permissions-policy"] == "camera=(), microphone=(), geolocation=()"
