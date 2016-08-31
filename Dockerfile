FROM ubuntu:16.10

RUN apt-get update -q           &&\
    apt-get install -qy openvpn   \
                        iptables  \
                        socat     \
                        curl


ADD ./bin /usr/local/sbin
VOLUME /etc/openvpn
EXPOSE 443/tcp 1194/udp 8080/tcp
CMD run
