
#--- stage 1 : build with next js ----
FROM node:24-alpine As builder

WORKDIR /app

COPY package*.json ./

RUN npm install && npm rebuild esbuild

COPY . .

RUN npm run build

#--- stage 2 : server with nginx ----

    FROM nginx:alpine 
    COPY --from=builder /app/dist usr/share/nginx/html

    COPY nginx.cong /etc/nginx/conf.d/default.conf

    EXPOSE 80

    CMD [ "nginx", "-g", "daemon off" ]