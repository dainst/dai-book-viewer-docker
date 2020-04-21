# dai-book-viewer-docker

## Setup

    git submodule --init update


## Development

    docker-compose up
    
The viewer is served at http://localhost:2223/?file=documents/example.pdf&pubid=example.json.


If you make changes to the submodule, you have to rebuild the docker image each time to apply changes by running:

    docker-compose build && docker-compose up

## Usage for OJS plugin

This repository is used to build relevant parts of our [OJS Plugin](https://github.com/dainst/dai-book-viewer-ojs-plugin).

## Pushing a new docker image for cilantro

    docker-compose -f docker-compose.cilantro.yml build

    docker push dainst/cilantro-dai-book-viewer:latest

