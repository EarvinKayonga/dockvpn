start :
	docker build -t dockervpn .
	docker run -d --name vpnContainer --privileged -p 1194:1194/udp -p 443:443/tcp dockervpn

getCerts:
	docker run -d --name serverConfig -p 8080:8080 --volumes-from vpnContainer dockervpn serveconfig
	wget --no-check-certificate https://localhost:8080 -O myConfig.ovpn
	docker rm -f serverConfig

serve:
	docker run -d --name serverConfig -p 8080:8080 --volumes-from vpnContainer dockervpn serveconfig

servestop:
	docker rm -f serverConfig

stop:
	docker rm -f vpnContainer

clean:
	docker rmi -f dockervpn

default: start
