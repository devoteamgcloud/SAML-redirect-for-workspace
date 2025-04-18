# Use an official Node.js runtime as a parent image
# Use a specific version matching your package.json 'engines' field if possible
FROM node:18-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
# Using package-lock.json with npm install is still recommended for locking versions
COPY package*.json ./

# Install app dependencies
# Using npm install instead of npm ci (less strict, doesn't require package-lock.json)
# Use --only=production to avoid installing devDependencies
RUN npm install --only=production --legacy-peer-deps

# Bundle app source code inside the Docker image
COPY . .

# Get the port from the environment variable PORT (provided by Cloud Run)
# Default to 8080 if PORT is not set (e.g., for local testing)
ENV PORT=8080
EXPOSE $PORT

# Define the command to run your app using the start script from package.json
# Use "npm start" which executes "functions-framework --target=dynamicRedirect --port=8080"
# The Functions Framework automatically listens on the PORT env var if set.
CMD ["npm", "start"]
