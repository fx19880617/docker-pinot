# docker-pinot
This is a docker image for [Apache Pinot](https://pinot.apache.org/)

## How to build it

Modify the `PINOT_BRANCH` to whatever branch or tag you wanna build, currently set to `origin/master`.

```SHELL
docker build --no-cache -t pinot:master  -f Dockerfile .
```

## Run it

The entry point is `pinot-admin.sh`.
