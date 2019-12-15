FROM node:10.16.0-alpine

WORKDIR /server
COPY package.json .
RUN yarn install

EXPOSE 8080

COPY . .

RUN yarn build
CMD yarn serve
