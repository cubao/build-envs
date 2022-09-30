#!/bin/bash

cd /etc/yum.repos.d && ls | grep -v 'CentOS-Base.repo' | xargs rm

# https://mirrors.tuna.tsinghua.edu.cn/help/centos-vault/
minorver=6.10
sed -e "s|^mirrorlist=|#mirrorlist=|g" \
    -e "s|^#baseurl=http://mirror.centos.org/centos/\$releasever|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-vault/$minorver|g" \
    -i.bak /etc/yum.repos.d/CentOS-*.repo

yum clean all && yum makecache