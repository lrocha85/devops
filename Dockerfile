FROM lrocha85/testeapp:1.1
EXPOSE 80:80
WORKDIR /opt/app1
COPY ./index.nginx-debian.html /tmp/
RUN apt-get update -y && apt-get install vim -y && apt-get install nginx -y
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
