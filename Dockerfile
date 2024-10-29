
FROM nginx:latest
WORKDIR /usr/share/nginx/html 
COPY index.html .
COPY index.css .
EXPOSE 80
