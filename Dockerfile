FROM nginx:1.14

# dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install git apt-transport-https nano gnupg wget
# we need a newer node version to get npm
RUN wget https://deb.nodesource.com/gpgkey/nodesource.gpg.key \
    && sh -c 'apt-key add nodesource.gpg.key > /dev/null 2>&1' \
    && sh -c 'echo "deb https://deb.nodesource.com/node_10.x stretch main" >> /etc/apt/sources.list.d/nodesource.list' \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs

RUN rm -R /usr/share/nginx/html/
COPY frontend /usr/share/nginx/html
COPY config/create_settings_from_env.sh /create_settings_from_env.sh
WORKDIR /usr/share/nginx/html
RUN npm update -g \
    && npm install

#write startup-script (which creates settings.json)
RUN touch /startup.sh \
    && echo "#!/bin/bash\n" >> /startup.sh \
    && echo "cd /usr/share/nginx/html/config\n" >> /startup.sh \
    && echo "/create_settings_from_env.sh" >> /startup.sh \
    && echo "nginx -g 'daemon off;'" >> /startup.sh \
    && chmod a+x /startup.sh \
    && chmod a+x /create_settings_from_env.sh

# startup script
ENTRYPOINT ["/startup.sh"]