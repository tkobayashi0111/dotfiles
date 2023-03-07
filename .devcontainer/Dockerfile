FROM debian:bullseye-slim as debian

RUN apt-get update && \
  apt-get install -y \
  curl \
  git


FROM alpine:latest as alpine

RUN apk update && \
  apk add \
  curl \
  git
