FROM golang:1.9-alpine as builder
RUN apk add --no-cache gcc libc-dev
WORKDIR /go/src/github.com/axoom/docker-volume-temp
COPY . .
RUN go install --ldflags '-extldflags "-static"'

FROM alpine as rootfs
RUN mkdir -p /run/docker/plugins /tmp/volumes
COPY --from=builder /go/bin/docker-volume-temp .

FROM docker
WORKDIR /plugin
COPY config.json .
COPY --from=rootfs / rootfs/
