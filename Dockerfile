
FROM alpine:latest AS build

ARG HUGO_VERSION=0.68.3

RUN apk add git

WORKDIR /tmp
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -O hugo.tar.gz \
	&& tar -xzf hugo.tar.gz \
	&& cp hugo /opt/hugo \
	&& rm -rf /tmp/*

WORKDIR /usr/src/app
COPY . .
RUN git submodule init && git submodule update --remote --merge
RUN /opt/hugo

FROM nginx:mainline

WORKDIR /usr/share/nginx/html

COPY --from=build /usr/src/app/public .
RUN chmod 777 /var/cache/nginx

EXPOSE 80

