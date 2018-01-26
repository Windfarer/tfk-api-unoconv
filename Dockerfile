# Setting the base to docker-node-unoconv
FROM telemark/docker-node-unoconv:8.9.3

RUN apt-get install -y locales locales-all
ENV TZ 'Asia/Shanghai'
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Maintainer
MAINTAINER Geir Gåsodden

#### Begin setup ####

# Bundle app source
COPY . /src

# Change working directory
WORKDIR "/src"

# Install dependencies
RUN npm install --production

# Env variables
ENV SERVER_PORT 3000
ENV TIMEOUT_SERVER 120000
ENV TIMEOUT_SOCKET 140000

# Expose 3000
EXPOSE 3000

# Startup
ENTRYPOINT /usr/bin/unoconv --listener --server=0.0.0.0 --port=2002 & node standalone.js