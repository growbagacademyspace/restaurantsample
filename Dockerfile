FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:stable-alpine 
COPY nginx.conf /etc/nginx/nginx.conf 
COPY --from=builder /app/dist/foodapp/browser /app/dist/foodapp/browser 
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]