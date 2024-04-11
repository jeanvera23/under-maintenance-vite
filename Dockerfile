# build
FROM node:18-alpine3.15 as builder
WORKDIR /app
COPY [".", "./"]
RUN yarn install; \
    yarn build

# nginx
FROM nginx:1.23.1-alpine
COPY --from=builder ["/app/dist", "/usr/share/nginx/html"]
COPY ["/nginx/nginx.conf", "/etc/nginx/conf.d"]

EXPOSE 3000
ENTRYPOINT ["nginx", "-g", "daemon off;"]