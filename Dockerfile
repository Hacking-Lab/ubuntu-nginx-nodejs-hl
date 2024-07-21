FROM hackinglab/ubuntu-base-hl:latest
LABEL maintainer="Ivan Buetler <ivan.buetler@compass-security.com>"

# Add the files

RUN apt-get update -y
RUN apt-get install sudo -y
RUN apt-get install -y curl ca-certificates gnupg

# Download and import the NodeSource GPG key
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg

# Set the desired Node.js version (change NODE_MAJOR as needed)
ENV NODE_MAJOR=21

# Create the NodeSource deb repository
RUN echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list

# Update and install Node.js
RUN apt-get update -y && apt-get install -y nodejs

# Install additional packages
RUN apt-get install -y \
        nginx \
        apache2-utils \
        openssl

ADD root /

# Create a system user for Node.js
RUN addgroup --system node && adduser --system --ingroup node node

# Set appropriate ownership and create a directory for Node.js
RUN chown -R www-data:www-data /var/lib/nginx
RUN mkdir -p /opt/nodejs && chown -R node:node /opt/nodejs

# Change to the Node.js directory and install npm packages
WORKDIR /opt/nodejs
RUN npm init -y
RUN npm install express

# Clean up the APT cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#USER node

# Expose the ports for nginx
EXPOSE 3000
