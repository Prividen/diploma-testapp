FROM nginx:stable
RUN mkdir /html
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
