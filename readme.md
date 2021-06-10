# dai-book-viewer-docker

## Setup

    git submodule --init update


## Development

    docker-compose up

The examples in [/sample](sample) are served together with the annotations in [/sample/annotations](sample/annotations) on these urls:

* http://localhost:2223/?file=documents/example.pdf&pubid=annotations/example.json
* http://localhost:2223/?file=documents/example2.pdf&pubid=annotations/example2.json

If you make changes to the submodule, you have to rebuild the docker image each time to apply changes by running:

    docker-compose up --build

## Usage in the OJS plugin

This repository is used to build relevant parts of our [OJS Plugin](https://github.com/dainst/dai-book-viewer-ojs-plugin). To copy the build directory for OJS:

```bash
docker-compose up --build
docker cp dai-book-viewer-docker_dai-book-viewer_1:/dai_book_viewer/build /path/to/OJS/plugin
```

## Deployment

Publish images:

```
docker-compose -f docker-compose.test.yml build
docker push dainst/dai-book-viewer-test
# OR
docker-compose -f docker-compose.prod.yml build
docker push dainst/dai-book-viewer
```

Copy the `docker-compose.(test|prod).yml` as a Stack definition in the [test](https://portainer.test.idai.world) or [prod portainer](https://portainer.idai.world).

On a new portainer setup you would need to create the external volumes pointing to the daicloud volumes.

Volumes > Add Volume

```
Name            bookviewer_data
Use NFS volume  [X]
Address         10.201.0.95
NFS Version     NFS
Mount Point     /volume3/DockerSwarmTest/bookviewer_public
Options         ro,noatime,rsize=8192,wsize=8192,tcp,timeo=14   (Defaults, but 'rw' -> 'ro')
```

For prod use the same but change the mountpoint:

```
Mount Point     /volume3/daicloud09/idaiworld-scans/idaibookviewer_public
```
