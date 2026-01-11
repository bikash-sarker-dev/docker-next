
# #--- stage 1 : build with next js ----
# FROM node:24-alpine As builder

# WORKDIR /app

# COPY package*.json ./

# RUN npm install && npm rebuild esbuild

# COPY . .

# RUN npm run build

# #--- stage 2 : server with nginx ----

#     FROM nginx:alpine 
#     COPY --from=builder /app/dist usr/share/nginx/html

#     COPY nginx.cong /etc/nginx/conf.d/default.conf

#     EXPOSE 80

#     CMD [ "nginx", "-g", "daemon off" ]



# --- Stage 1: Build Next.js ---
FROM node:24-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# --- Stage 2: Nginx ---
FROM nginx:alpine

# COPY --from=builder /app/next /usr/share/nginx/html
COPY --from=builder /app/out /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
