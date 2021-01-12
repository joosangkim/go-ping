# syntax=docker/dockerfile:1.0.0-experimental
#
# Note: To download private dependencies you must enable buildkit and SSH agent forwarding to build
# this image. You must also use a sufficiently recent Docker Engine.
# $ DOCKER_BUILDKIT=1 docker build --ssh default .
#
FROM golang:1.13-alpine AS build
ARG project_name="ping"
ARG project_repo="joosangkim/${project_name}"

# BEGIN common build for go projects
RUN mkdir -p /go/src/github.com/$project_repo ~/.ssh && \
    apk add --no-cache git openssh-client make gcc libc-dev

WORKDIR /go/src/github.com/joosangkim/ping
COPY . .
RUN go build -o ping -i main.go
# END common build for go projects

FROM alpine:3
COPY --from=build /go/src/github.com/joosangkim/ping/ping /bin/ping
CMD /bin/ping
