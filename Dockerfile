FROM ubuntu:latest
CMD wget -O /usr/local/bin/hysteria https://cdn.jsdelivr.net/gh/none-blue/hysteria-amd64@main/hysteria
CMD wget -O /usr/local/bin/xray https://cdn.jsdelivr.net/gh/none-blue/xray-amd64@main/xray
CMD chmod +x /usr/local/bin/{hysteria,xray}

CMD hysetia -V
CMD xray version

CMD mkdir -p /etc/hysteria
CMD xray tls cert --ca \
--domain="cdn" \
--name="CDN Inc" \
--org="CDN Inc" \
--expire=876000h \
--file=/etc/hysteria/ \
--json=false

CMD cat << EOF > /etc/hysteria/config.json
{
  "listen": ":443",
  "cert": "/etc/hysteria/_cert.pem",
  "key": "/etc/hysteria/_key.pem",
  "obfs": "123"
}
EOF

CMD nohup hysteria -c /etc/hysteria/config.json server > /dev/null 2>&1 &
