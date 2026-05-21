# Render deployment

This project runs as two Render services:

- `ruoyi-mysql`: private MySQL service with a persistent disk.
- `ruoyi-redis`: Render Key Value service.
- `ruoyi`: Docker web service for the Spring Boot backend.
- `ruoyi-vue`: Static Site for the Vue frontend.

The root `render.yaml` Blueprint creates `ruoyi-mysql`, `ruoyi-redis`,
`ruoyi`, and `ruoyi-vue` together. MySQL and Redis connection variables are
injected automatically into the backend.

## Backend service

Use these settings if creating the service manually:

- Runtime: Docker
- Root Directory: `wms-ruoyi`
- Dockerfile Path: `./Dockerfile`

Environment variables:

```text
SPRING_PROFILES_ACTIVE=render
TZ=Asia/Shanghai
MYSQL_HOST=<injected by Blueprint>
MYSQL_PORT=3306
MYSQL_DATABASE=ry_wms
MYSQL_USER=ruoyi
MYSQL_PASSWORD=<injected by Blueprint>
REDIS_URL=<injected by Blueprint>
```

Render injects `PORT` automatically. If you deploy from the root `render.yaml`
Blueprint, Render creates MySQL and Key Value services and fills the backend
database/cache variables automatically.

## Frontend static site

- Root Directory: `ruo-yi-wms-vue`
- Build Command: `npm ci && npm run build:prod`
- Publish Directory: `dist`

Environment variables:

```text
VITE_APP_BASE_API=https://<your-backend-service>.onrender.com
VITE_APP_CONTEXT_PATH=/
```

Add this rewrite rule for Vue Router:

```text
Source: /*
Destination: /index.html
Action: Rewrite
```

## Database

The `ruoyi-mysql` Docker image imports `ry_wms_full.sql` automatically on the
first MySQL startup, before the persistent disk has data.
