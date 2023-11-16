# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install app dependencies
RUN npm install

# Create a 'src' directory and copy the server.js file
RUN mkdir src
COPY src/server.js src/

# Expose the port on which the app will run
EXPOSE 8080

# Define the command to run your app
CMD ["node", "src/server.js"]
