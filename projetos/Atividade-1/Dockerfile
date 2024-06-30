FROM nginx:latest

RUN rm /usr/share/nginx/html/index.html

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

# Iniciando o NGINX
CMD ["nginx", "-g", "daemon off;"]
