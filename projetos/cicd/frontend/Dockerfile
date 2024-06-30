# Builder
FROM node:18.20.3-alpine3.20 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install -g @angular/cli

RUN npm ci

COPY . .

RUN ng build --configuration production

# Imagem Final
FROM nginx:stable-alpine3.19-slim

COPY --from=builder /app/dist /usr/share/nginx/html

COPY default.conf  /etc/nginx/conf.d/default.conf

EXPOSE 80

