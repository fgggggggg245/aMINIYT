FROM debian:bookworm-slim

COPY install.sh /app/install.sh

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash git curl wget unzip tzdata openssl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x /app/install.sh && /app/install.sh
COPY config.json /etc/config.json

RUN echo 'echo -e "\n✅ VLESS LINKS:\n\
1️⃣  vless://550e8400-e29b-41d4-a716-446655440000@94.130.50.12:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${CODESPACE_NAME}-443.app.github.dev&path=%2F#ghtun-443\n\
2️⃣  vless://550e8400-e29b-41d4-a716-446655440000@94.130.33.41:8080?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${CODESPACE_NAME}-8080.app.github.dev&path=%2F#ghtun-8080\n\
3️⃣  vless://550e8400-e29b-41d4-a716-446655440000@204.12.196.34:8443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${CODESPACE_NAME}-8443.app.github.dev&path=%2F#ghtun-8443\n\
4️⃣  vless://550e8400-e29b-41d4-a716-446655440000@87.248.156.197:80?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${CODESPACE_NAME}-80.app.github.dev&path=%2F#ghtun-80"' >> /etc/bash.bashrc

CMD ["/usr/local/bin/xray", "-c", "/etc/config.json"]
