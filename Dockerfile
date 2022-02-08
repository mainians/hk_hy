FROM ubuntu:latest
RUN apt update -yqq
RUN apt install -yqq wget

RUN wget -qO hysteria https://cdn.jsdelivr.net/gh/none-blue/hysteria-amd64@main/hysteria
RUN wget -qO xray https://cdn.jsdelivr.net/gh/none-blue/xray-amd64@main/xray
RUN chmod +x ./hysteria
RUN chmod +x ./xray

RUN mkdir -p /etc/hysteria
RUN ./xray tls cert --ca \
--domain="cdn" \
--name="CDN Inc" \
--org="CDN Inc" \
--expire=876000h \
--file=/etc/hysteria/ \
--json=false

RUN wget -qO /etc/hysteria/config.json https://cdn.jsdelivr.net/gh/mainians/hk_hy@main/config.json

RUN ./hysteria -c /etc/hysteria/config.json server

CMD ./hysteria -c /etc/hysteria/config.json server

CMD [ "nohup", "./hysteria", "-c", "/etc/hysteria/config.json", "server",">/dev/null","2>&1","&" ]
