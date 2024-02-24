

FROM alpine:latest

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
RUN mkdir -m 777 /usr/src/app/resources

EXPOSE 1313
CMD [ "/opt/hugo", "server", "--bind=0.0.0.0" ]

