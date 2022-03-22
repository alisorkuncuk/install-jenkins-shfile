docker network create --driver=bridge finspire

docker volume create jenkins-log 
docker volume create jenkins-data



docker container run -d \
--name jenkins \
--restart always \
-p 8080:8080  -p 50000:50000 \
--network finspire \
-v jenkins-log:/var/log/jenkins \
-v jenkins-data:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /data/docker/bind-mounts/jenkins/downloads:/var/jenkins_home/downloads \
-v /usr/bin/docker:/usr/bin/docker \
--env VIRTUAL_HOST=jenkins.finspire.tech \
--env VIRTUAL_PORT=8080 \
--env JAVA_OPTS=-Xmx4g \
--env LETSENCRYPT_HOST=jenkins.finspire.tech \
--env LETSENCRYPT_EMAIL=admin@finspiretech.com \
bitnami/jenkins:2.319.3 
