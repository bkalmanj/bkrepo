#!/bin/bash
#Install Nginx
apt update && apt install -y nginx 
webapp=$1

#Configure Nginx conf
cat <<EOF > /etc/nginx/sites-available/default
server {
  listen 80;
  listen [::]:80;

  server_name $webapp;

  location / {
      proxy_pass http://$webapp;
      proxy_set_header X-Real-IP $remote_addr;

  }
}
EOF

#Restart Nginx
systemctl restart nginx
