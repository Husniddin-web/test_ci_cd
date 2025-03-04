FROM node:alpine as builder
WORKDIR /app
ADD package*.json ./
RUN npm ci
RUN npm run build --prod


FROM node:alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
ADD package*.json ./
RUN npm ci
CMD [ "node","./dist/main.js" ]