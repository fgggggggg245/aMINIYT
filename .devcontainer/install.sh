#!/bin/bash

echo "downloading xray"
wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v26.3.27/Xray-linux-64.zip

echo "installing"
unzip -q /tmp/xray.zip -d /tmp/xray_extract
chmod +x /tmp/xray_extract/xray
mv /tmp/xray_extract/xray /usr/local/bin/xray
rm -rf /tmp/xray.zip /tmp/xray_extract

echo "installed!"

# اضافه کردن اسکریپت نمایش لینک به bash.bashrc
cat << 'EOF' >> /etc/bash.bashrc

# نمایش لینک‌های کانفیگ
show_links() {
  IP="94.130.50.12"
  CODESPACE_HOST="${CODESPACE_NAME}-443.app.github.dev"
  
  echo -e "\n✅========== کانفیگ‌های آماده ==========✅"
  
  # VLESS روی پورت 443 (همان کد اصلی)
  echo -e "\n🔹 VLESS (پورت 443):"
  echo "vless://550e8400-e29b-41d4-a716-446655440000@${IP}:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${CODESPACE_HOST}&path=%2F#ghtun-vless"
  
  # VMess روی پورت 8443
  VMESS_JSON=$(echo -n '{"v":"2","ps":"ghtun-vmess","add":"'$IP'","port":8443,"id":"550e8400-e29b-41d4-a716-446655440001","aid":"0","net":"ws","type":"none","host":"'$CODESPACE_HOST'","path":"/vmess","tls":"tls"}' | base64 -w 0)
  echo -e "\n🔹 VMess (پورت 8443):"
  echo "vmess://${VMESS_JSON}"
  
  # Trojan روی پورت 4443
  echo -e "\n🔹 Trojan (پورت 4443):"
  echo "trojan://trojan-pass-123@${IP}:4443?security=tls&sni=${CODESPACE_HOST}&type=grpc&serviceName=trojan#ghtun-trojan"
  
  # Shadowsocks روی پورت 4453
  SS_PASSWORD=$(echo -n "chacha20-ietf-poly1305:ss-pass-456" | base64 -w 0)
  echo -e "\n🔹 Shadowsocks (پورت 4453):"
  echo "ss://${SS_PASSWORD}@${IP}:4453#ghtun-ss"
  
  echo -e "\n✅==================================✅\n"
}

show_links
EOF

echo "✅ لینک‌های کانفیگ پس از اتصال نمایش داده می‌شوند"
