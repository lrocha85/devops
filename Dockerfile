FROM lrocha85/testeapp:1.1
EXPOSE 80:80
WORKDIR /opt/app1
COPY ./index.nginx-debian.html /tmp/
RUN apt-get update -y && apt-get install vim -y && apt-get install nginx -y
