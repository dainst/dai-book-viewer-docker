# Dai-Book-Viewer Container

## Development build

    git clone https://github.com/dainst/dai-book-viewer-docker
    cd dai-book-viewer-docker
    git submodule init
    git submodule update
    cd ..
    docker-compose -f docker-compose.dev.yml up
    
Goto: http://localhost:2222/?file=documents/example.pdf&pubid=example.json

To make changes visible in the dev application you might have to trigger a rebuild and copy some files into place:

```
docker exec -it dai-book-viewer-docker_dai-book-viewer_1 npm run build
docker exec -it dai-book-viewer-docker_dai-book-viewer_1 cp -r build/* /usr/share/nginx/html/
```
