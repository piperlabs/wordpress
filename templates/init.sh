#!/bin/bash -e

cat > /tmp/createdatabase.sql << EOF
CREATE DATABASE {{ .product.db.name }} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER '{{ .product.db.user }}'@'localhost' IDENTIFIED BY '{{ .product.db.password }}';
GRANT ALL PRIVILEGES ON {{ .product.db.name }}.* TO '{{ .product.db.user }}'@'localhost';
FLUSH PRIVILEGES;
EOF
mysql -u root -p{{ .sql.rootpassword }} < /tmp/createdatabase.sql
rm /tmp/createdatabase.sql

curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> {{ .apache.documentRoot }}/wp-config.php
