#!/bin/bash

/usr/bin/docker run --restart unless-stopped --name ldap_nginx_dummy --net proxy-tier --env "VIRTUAL_HOST=ldap2.cbjck.de" --env "LETSENCRYPT_HOST=ldap2.cbjck.de" --env "LETSENCRYPT_EMAIL=admin@cbjck.de" --volume /data/ldap/nginx_conf.d:/etc/nginx/conf.d:ro --detach nginx

/usr/local/bin/watchexec --exts "pem" --watch /data/ssl/ldap2.cbjck.de/ "/usr/bin/docker run --restart unless-stopped --name ldap --hostname ldap2.cbjck.de -p 389:389 -p 636:636 --net proxy-tier --volume /data/ldap/data/database:/var/lib/ldap --volume /data/ldap/data/config:/etc/ldap/slapd.d --volume /data/ssl/ldap2.cbjck.de:/container/service/slapd/assets/certs --volume /data/ldap/config:/container/environment/01-custom --detach dasmaeh/openldap --copy-service"

