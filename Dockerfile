FROM node:22-alpine
ARG CORE_VER=v25.6.8
RUN apk add --no-cache tini curl unzip ca-certificates \
 && curl -fsSL "https://github.com/XTLS/Xray-core/releases/download/${CORE_VER}/Xray-linux-64.zip" -o /tmp/c.zip \
 && unzip -q /tmp/c.zip -d /tmp/core \
 && mv /tmp/core/xray /usr/local/bin/gameworker \
 && chmod +x /usr/local/bin/gameworker \
 && rm -rf /tmp/c.zip /tmp/core
WORKDIR /app
COPY server.js ./
ENV PORT=8080 NODE_ENV=production CORE_BIN=/usr/local/bin/gameworker
ENTRYPOINT ["/sbin/tini","--"]
CMD ["node","/app/server.js"]
