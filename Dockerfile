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

# build viewer dependencies
WORKDIR /dai_book_viewer
COPY dai-book-viewer/package.json .
RUN npm update -g \
    && npm install

# build viewer
ENV SERVE_DIR="/usr/share/nginx/html"
COPY dai-book-viewer .
COPY config/viewer_preferences.json src/default_preferences.json
RUN mkdir -p build \
    && chmod -R 777 build \
    && npm run build \
    && rm -R "$SERVE_DIR"/* \
    && mkdir "$SERVE_DIR"/annotations \
    && cp -r build/* "$SERVE_DIR" \
    && mv "$SERVE_DIR"/viewer.html "$SERVE_DIR"/index.html

# write startup-script
COPY docker-entrypoint.sh /docker-entrypoint.sh

# startup script
ENTRYPOINT ["/docker-entrypoint.sh"]
