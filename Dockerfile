FROM ubuntu:latest
RUN apt update
RUN apt install -y wget

RUN wget -O /usr/local/bin/hysteria https://cdn.jsdelivr.net/gh/none-blue/hysteria-amd64@main/hysteria
RUN wget -O /usr/local/bin/xray https://cdn.jsdelivr.net/gh/none-blue/xray-amd64@main/xray
RUN chmod +x /usr/local/bin/{hysteria,xray}

RUN hysetia -V
RUN xray version

RUN mkdir -p /etc/hysteria
RUN xray tls cert --ca \
--domain="cdn" \
--name="CDN Inc" \
--org="CDN Inc" \
--expire=876000h \
--file=/etc/hysteria/ \
--json=false

RUN wget -O /etc/hysteria/config.json https://cdn.jsdelivr.net/gh/mainians/hk_hy@main/config.json

CMD nohup hysteria -c /etc/hysteria/config.json server >/dev/null 2>&1 &
