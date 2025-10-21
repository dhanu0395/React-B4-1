# ---------- Stage 1: Build the React app ----------
FROM node:18-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80

# Correct CMD syntax (ASCII spaces only)
CMD ["nginx", "-g", "daemon off;"]

