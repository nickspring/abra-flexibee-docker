# Abra Flexibee in Docker

## Disclaimer

This is unofficial repository, I don't have any relation to Abra Flexibee publisher, but I'm actively using this software.

## Usage

This repo is dedicated to building Docker image for Abra Flexibee.
Just checkout it and build Dockerfile. It should download latest *.deb file and integrated it in image.

```shell
docker compose up
```

After starting simple run Abra Flexibee and choose new data server:

* host - localhost
* port - 15434

## Kuberenets

To deploy Flexibee on Kubernetes, please see `manifests` folder.

## TODO

* Add Nginx to docker-compose to server web version of Flexibee
