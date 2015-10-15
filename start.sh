#!/bin/bash
mkdir /root/.ssh/
$PUBLIC_KEY > /root/.ssh/id_rsa
touch /root/.ssh/known_hosts
ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
git clone $REPO /root/app
cd /root/app
export SECRET_KEY_BASE=$(rake secret) && \
    rake db:migrate && \
    bundle install \ 
    rails s -b 0.0.0.0