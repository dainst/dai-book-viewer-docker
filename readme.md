# dai-book-viewer-docker


## Setup

    git submodule --init update
    docker-compose build
    docker-compose up
    
Goto: http://localhost:2223/?file=documents/example.pdf&pubid=example.json

## Development

If you make changes to the submodule, you have to rebuild the docker image each time to apply changes by running:

    docker-compose build && docker-compose up


## Usage for OJS plugin

This repository is used to build relevant parts of our [OJS Plugin](https://github.com/dainst/dai-book-viewer-ojs-plugin).
