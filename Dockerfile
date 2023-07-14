FROM hackinglab/ubuntu-base-hl:latest
MAINTAINER Ivan Buetler <ivan.buetler@compass-security.com>

# Add the files

RUN apt-get update -y
RUN apt-get install sudo -y
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
    sudo apt-get install -y nodejs

RUN apt-get install -y \
        nginx \
        apache2-utils \
        openssl

ADD root /
RUN addgroup --system node && adduser --system --ingroup node node && \
	chown -R www-data:www-data /var/lib/nginx && \
	mkdir -p /opt/nodejs && chown -R node:node /opt/nodejs && \
        cd /opt/nodejs && \
        npm i && \
        npm i express --save && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

#USER node
# Expose the ports for nginx
EXPOSE 3000

