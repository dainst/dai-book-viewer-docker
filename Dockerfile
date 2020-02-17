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

# build viewer
COPY dai-book-viewer /dai_book_viewer
WORKDIR /dai_book_viewer
RUN mkdir build
RUN chmod -R 777 build
RUN npm update -g \
    && npm install
COPY config/viewer_preferences.json /dai_book_viewer/src/default_preferences.json
#RUN cp /dai_book_viewer/src/dev_preferences.json /dai_book_viewer/src/default_preferences.json
RUN npm run build
RUN rm -R /usr/share/nginx/html/*
RUN cp -r build/* /usr/share/nginx/html/

RUN mv /usr/share/nginx/html/viewer.html /usr/share/nginx/html/index.html

# annotation directory (for local annotations)
RUN mkdir /usr/share/nginx/html/annotations

#write startup-script (which creates settings.json)

COPY docker-entrypoint.sh /docker-entrypoint.sh

# startup script
ENTRYPOINT ["/docker-entrypoint.sh"]