#!/bin/sh

wget -qO /usr/local/bin/hysteria https://cdn.jsdelivr.net/gh/none-blue/hysteria-amd64@main/hysteria
wget -qO /usr/local/bin/xray https://cdn.jsdelivr.net/gh/none-blue/xray-amd64@main/xray
chmod +x /usr/local/bin/{hysteria,xray}

hysetia -V
xray version

mkdir -p /etc/hysteria
xray tls cert --ca \
--domain="cdn" \
--name="CDN Inc" \
--org="CDN Inc" \
--expire=876000h \
--file=/etc/hysteria/ \
--json=false

cat << EOF > /etc/hysteria/config.json
{
  "listen": ":443",
  "cert": "/etc/hysteria/_cert.pem",
  "key": "/etc/hysteria/_key.pem",
  "obfs": "123"
}
EOF

nohup hysteria -c /etc/hysteria/config.json server > /dev/null 2>&1 &
