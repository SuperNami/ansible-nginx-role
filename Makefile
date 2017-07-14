### Nginx
nginx: ng



### Naxsi + Geoip
ng: ng-download ng-compile ng-configure np-configure-ssl np-configure-http np-configure-server np-configure-naxsi np-after-compile np-logrotate
ng-download: compile-preparation download-naxsi-git download-geoip-local download-openssl-release-github
ng-compile: naxsi-geoip compile-nginx systemd-nginx
ng-configure: configure-nginx configure-default
np-configure-ssl: prime configure-ssl
np-configure-http: configure-cloudflare configure-fastcgi-http configure-upstream-both
np-configure-server: configure-fastcgi-server configure-security configure-upstream-server
np-configure-naxsi: configure-naxsi
np-after-compile: after-compile
np-logrotate: configure-logrotate



### Naxsi + Pagespeed + Cachepurge + Geoip
npcg: npcg-download npcg-compile npcg-configure-nginx npcg-configure-ssl npcg-configure-http npcg-configure-server npcg-configure-naxsi npcg-after-compile npcg-logrotate
npcg-download: compile-preparation download-naxsi-git download-geoip-local download-openssl-release-github download-pagespeed download-cachepurge
npcg-compile: naxsi-pagespeed-cachepurge-geoip compile-nginx systemd-nginx
npcg-configure-nginx: configure-nginx configure-default
npcg-configure-ssl: prime configure-ssl
npcg-configure-http: configure-cloudflare configure-fastcgi-http configure-fastcgi-cache-purge-http configure-pagespeed-http configure-upstream-both
npcg-configure-server: configure-fastcgi-server configure-fastcgi-cache-purge-server configure-pagespeed-server configure-security configure-upstream-server
npcg-configure-naxsi: configure-naxsi
npcg-after-compile: after-compile
npcg-logrotate: configure-logrotate



### Apt
apt-install:
	# Install
	ansible-playbook main.yml -i localhost -t install_nginx



### Compile preparation
compile-preparation:
	# Compile preparation
	ansible-playbook main.yml -i localhost -t compile_preparation



##### Downloads
## Naxsi
download-naxsi-release:
	# Download naxsi release
	ansible-playbook main.yml -i localhost -t download_naxsi_release

download-naxsi-git:
	# Download naxsi git
	ansible-playbook main.yml -i localhost -t download_naxsi_git


## Geoip
download-geoip-local:
	# Download geoip local
	ansible-playbook main.yml -i localhost -t download_geoip_local

download-geoip-release:
	# Download geoip release
	ansible-playbook main.yml -i localhost -t download_geoip_release


## OpenSSL
download-openssl-git:
	# Download openssl git
	ansible-playbook main.yml -i localhost -t download_openssl_git

download-openssl-release-github:
	# Download openssl release github
	ansible-playbook main.yml -i localhost -t download_openssl_release_github

download-openssl-release-web:
	# Download openssl release web
	ansible-playbook main.yml -i localhost -t download_openssl_release_web

download-openssl:
	# Download openssl release web
	ansible-playbook main.yml -i localhost -t download_openssl


## Pagespeed
download-pagespeed:
	# Download pagespeed
	ansible-playbook main.yml -i localhost -t download_pagespeed

## Cache purge
download-cachepurge:
	# Download cachepurge
	ansible-playbook main.yml -i localhost -t download_cachepurge



##### Compile

naxsi-geoip:
	# Configure naxsi & geoip compilation
	ansible-playbook main.yml -i localhost -t naxsi_geoip

naxsi-pagespeed-cachepurge-geoip:
	# Configure naxsi & geoip compilation
	ansible-playbook main.yml -i localhost -t naxsi_pagespeed_cachepurge_geoip

compile-nginx:
	# Compile nginx
	ansible-playbook main.yml -i localhost -t compile_nginx



##### Systemd

systemd-nginx:
	# Deploy systemd script nginx
	ansible-playbook main.yml -i localhost -t systemd_nginx



##### Configure

## Nginx
configure-nginx:
	# Configure nginx
	ansible-playbook main.yml -i localhost -t configure_nginx

configure-default:
	# Configure default
	ansible-playbook main.yml -i localhost -t configure_default

nginx-tmpfs:
	# Configure tmpfs
	ansible-playbook main.yml -i localhost -t nginx_tmpfs


## Conf HTTP
configure-cloudflare:
	# Configure cloudflare
	ansible-playbook main.yml -i localhost -t configure_cloudflare

configure-fastcgi-cache-purge-http:
	# Configure fastcgi cache purge
	ansible-playbook main.yml -i localhost -t configure_fastcgi_cache_purge_http

configure-fastcgi-http:
	# Configure fastcgi
	ansible-playbook main.yml -i localhost -t configure_fastcgi_http

configure-pagespeed-http:
	# Configure pagespeed http
	ansible-playbook main.yml -i localhost -t configure_pagespeed_http

configure-upstream-both:
	# Configure upstream
	ansible-playbook main.yml -i localhost -t configure_upstream_both

configure-upstream-hhvm:
	# Configure hhvm
	ansible-playbook main.yml -i localhost -t configure_upstream_hhvm

configure-upstream-php-fpm:
	# Configure php-fpm
	ansible-playbook main.yml -i localhost -t configure_upstream_php_fpm


## Conf server
configure-fastcgi-server:
	# Configure server
	ansible-playbook main.yml -i localhost -t configure_fastcgi_server

configure-fastcgi-cache-purge-server:
	# Configure server
	ansible-playbook main.yml -i localhost -t configure_fastcgi_cache_purge_server

configure-pagespeed-server:
	# Configure pagespeed
	ansible-playbook main.yml -i localhost -t configure_pagespeed_server

configure-security:
	# Configure pagespeed
	ansible-playbook main.yml -i localhost -t configure_security

configure-upstream-server:
	# Configure fastcgi
	ansible-playbook main.yml -i localhost -t configure_upstream_server


## Naxsi
configure-naxsi:
	# Configure naxsi
	ansible-playbook main.yml -i localhost -t configure_naxsi


## SSL
prime:
	# Generate prime
	ansible-playbook main.yml -i localhost -t prime

configure-ssl:
	# Configure ssl
	ansible-playbook main.yml -i localhost -t configure_ssl



##### After compile
after-compile:
	# After compile
	ansible-playbook main.yml -i localhost -t after_compile



##### Logrotate
configure-logrotate:
	# Configure logrotate
	ansible-playbook main.yml -i localhost -t configure_logrotate


config-test: config-test-main config-test-website

config-test-main:
	nginx -t -c /etc/nginx/nginx.conf

config-test-website:
	nginx -t -c /etc/nginx/sites-enabled/website.com.conf
