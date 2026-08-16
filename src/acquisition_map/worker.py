"""Cloudflare Python Worker entrypoint for the FastAPI ASGI app."""

import asgi
from workers import WorkerEntrypoint

from acquisition_map.app import app


class Default(WorkerEntrypoint):
    """Delegate Cloudflare fetch events into FastAPI through ASGI."""

    async def fetch(self, request):
        return await asgi.fetch(app, request, self.env)
