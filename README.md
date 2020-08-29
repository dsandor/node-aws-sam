# docker-node-aws-sam

Builds a docker image with the tools needed for the following:

- nodejs
- npm
- aws-cli
- semantic-release
- aws sam-cli

This image is currently published to dockerhub (as it contains only a collection of public third party tools).

Published as: `dsandor/node-aws-sam:latest` 

[https://hub.docker.com/repository/docker/dsandor/node-aws-sam](https://hub.docker.com/repository/docker/dsandor/node-aws-sam)

## Why

This docker image pulls in the tools needed for CICD. It has the node tools I need for building React or VueJS web applications or NodeJS based API's and AWS Lambda functions. In addition since it has the AWS CLI and the AWS SAM CLI it provides a way to deploy the built code as well.

_I am not a docker guru._ I did my best and welcome pull requests. I attempted to make the image as small as possible by deleting caches and other things I did not feel was necessary. If someone is good at 'trimming the fat' please assist :)


## Built with:

```
docker build --squash .
```

## Run and drop in on bash:

```
docker run -it --entrypoint /bin/bash dsandor/node-aws-sam:latest
```

## tag version for release

```
docker tag <image hash> dsandor/node-aws-sam:latest
```

## push latest tag to docker

```
docker push dsandor/node-aws-sam:latest
```