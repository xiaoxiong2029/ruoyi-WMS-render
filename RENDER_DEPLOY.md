# Render deployment

This project runs as two Render services:

- `ruoyi`: Docker web service for the Spring Boot backend.
- `ruoyi-vue`: Static Site for the Vue frontend.

## Backend service

Use these settings if creating the service manually:

- Runtime: Docker
- Root Directory: `wms-ruoyi`
- Dockerfile Path: `./Dockerfile`

Environment variables:

```text
SPRING_PROFILES_ACTIVE=render
TZ=Asia/Shanghai
MYSQL_HOST=<your mysql internal host>
MYSQL_PORT=3306
MYSQL_DATABASE=ry_wms
MYSQL_USER=<your mysql user>
MYSQL_PASSWORD=<your mysql password>
REDIS_URL=<Render Key Value internal URL>
```

Render injects `PORT` automatically. If you deploy from the root `render.yaml`
Blueprint, Render creates the `ruoyi-redis` Key Value service and fills
`REDIS_URL` automatically.

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

Create database `ry_wms`, then import `ry_wms_full.sql`.
