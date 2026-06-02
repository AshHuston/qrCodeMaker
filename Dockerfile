# Build stage
FROM node:20-alpine as build

WORKDIR /app

ARG VITE_APP_HOST
ENV VITE_APP_HOST=$VITE_APP_HOST

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# Serve stage
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
