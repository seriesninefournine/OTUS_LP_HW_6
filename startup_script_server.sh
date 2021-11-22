#!/bin/bash
#Если ошибка, то выходим из скрипта
set -e

#Устанавливаем необхобимые пакеты
dnf install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc perl-IPC-Cmd

#Скачиваем необхобимые для сборки пакеты
wget https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm
rpm -i nginx-1.20.2-1.el8.ngx.src.rpm

wget https://www.openssl.org/source/openssl-3.0.0.tar.gz
tar -xf openssl-3.0.0.tar.gz

#Добавляем в файл spec необходимые параметры, скачиваем зависимости и собираем nginx
sed -i '114i\ \ \ \ --with-openssl=/home/vagrant/openssl-3.0.0 \\' ~/rpmbuild/SPECS/nginx.spec
yum-builddep -y ~/rpmbuild/SPECS/nginx.spec
rpmbuild -bb ~/rpmbuild/SPECS/nginx.spec

#~/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm

#Устанавливаем собраный пакет
dnf install -y ~/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm
systemctl enable --now nginx

#Создаем репозиторий
mkdir /usr/share/nginx/html/repo
cp ~/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm /usr/share/nginx/html/repo/
cd /usr/share/nginx/html/repo/
wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-server-8.0.27-1.el8.x86_64.rpm
createrepo /usr/share/nginx/html/repo/

#Включаем отображение содержимого в каталоге
sed -i '10i autoindex on;' /etc/nginx/conf.d/default.conf
systemctl reload nginx


#Добавляем репозиторий
echo \
"[myrepo]
name=myrepo
baseurl=http://localhost/repo/
gpgcheck=0
priority=1
enabled=1" > /etc/yum.repos.d/myrepo.repo