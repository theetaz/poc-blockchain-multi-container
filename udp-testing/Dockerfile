FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY client.js .
EXPOSE 4500
CMD ["node", "client.js"]