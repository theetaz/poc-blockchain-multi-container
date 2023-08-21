FROM node:16-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY client.js .

# Create a user with a known UID/GID within range 10000-20000.
# This is required by Choreo to run the container as a non-root user.
RUN adduser \
    --disabled-password \
    --gecos "" \
    --uid 10014 \
    "choreo"

# Use the above created unprivileged user
USER 10014

EXPOSE 4500

CMD ["node", "client.js"]