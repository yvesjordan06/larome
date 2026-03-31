# Stage 1: Build the Vue application
# Replace '22-alpine' with your required Node version
FROM node:22-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the application with Nginx
FROM nginx:stable-alpine AS production-stage
# Copy the build output from Vite (defaults to 'dist') to Nginx's public folder
COPY --from=build-stage /app/dist /usr/share/nginx/html
# Copy custom nginx config if you have one (see step 2)
# COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
