import sys
from pathlib import Path

if len(sys.argv) != 2:
    raise SystemExit(
        f"Usage: {sys.argv[0]} <path-to-dockerfile>"
    )

dockerfile = Path(sys.argv[1])

if not dockerfile.is_file():
    raise SystemExit(
        f"Dockerfile not found: {dockerfile}"
    )

text = dockerfile.read_text()

old_backend = """FROM node:24-alpine AS backend-dependencies
RUN apk add --no-cache python3
WORKDIR /opt/app
COPY backend/package.json backend/package-lock.json ./
RUN npm ci
"""

new_backend = """FROM node:24-alpine AS backend-dependencies
RUN apk add --no-cache python3 make g++
WORKDIR /opt/app
COPY backend/package.json backend/package-lock.json ./
RUN npm ci
RUN npm install --no-save node-addon-api node-gyp @img/sharp-libvips-dev
RUN CFLAGS="-march=x86-64 -mtune=generic" \\
    CXXFLAGS="-march=x86-64 -mtune=generic" \\
    npm explore sharp -- npm run build
"""

old_runner = """FROM node:24-alpine AS runner
ENV NODE_ENV=docker
"""

new_runner = """FROM node:24-alpine AS runner
ENV NODE_ENV=docker
ENV LD_LIBRARY_PATH=/opt/app/backend/node_modules/@img/sharp-libvips-linuxmusl-x64/lib
"""

if text.count(old_backend) != 1:
    raise SystemExit(
        f"Expected exactly 1 backend block, found {text.count(old_backend)}"
    )

if text.count(old_runner) != 1:
    raise SystemExit(
        f"Expected exactly 1 runner block, found {text.count(old_runner)}"
    )

text = text.replace(old_backend, new_backend)
text = text.replace(old_runner, new_runner)

dockerfile.write_text(text)

print("x86-64-v1 patch applied successfully.")
