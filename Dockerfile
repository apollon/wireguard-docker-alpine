FROM alpine:latest

RUN apk add --no-cache --update wireguard-tools iptables ip6tables

COPY ./conf/wg0.conf /etc/wireguard/

RUN mkdir /etc/wireguard/util
WORKDIR /etc/wireguard/util/
COPY main.sh .
RUN chmod +x main.sh

#COPY wg-genkey.sh .
#RUN chmod +x wg-genkey.sh

EXPOSE 51820/udp

#ENTRYPOINT [ "/etc/wireguard/util/wg-genkey.sh" ]
ENTRYPOINT [ "/etc/wireguard/util/main.sh" ]
