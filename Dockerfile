FROM node:8-alpine

RUN mkdir /data
WORKDIR /data

COPY package.json /data/
RUN apk add --no-cache --virtual .gyp \
	git \
	make \
	g++ \
	python \
	&& npm install \
	&& apk del .gyp \ 
	&& npm install --global gulp@3.9.1 \
	&& npm link gulp

COPY gulpfile.js webpack-config.js /data/
COPY ./src/js/config.example.js /data/src/js/config.js

RUN gulp scripts scss 
