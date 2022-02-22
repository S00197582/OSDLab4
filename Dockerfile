
FROM node:14.15.4 AS builder

WORKDIR /DockerLab4

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.13.12-alpine

COPY --from=builder /DockerLab4/dist/DockerLab4 /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'