# Use an official Node.js runtime as a parent image
# Use a specific version matching your package.json 'engines' field if possible
FROM node:18-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
# This step leverages Docker layer caching
COPY package*.json ./

# Install app dependencies using a clean install for better reproducibility
# Use --only=production to avoid installing devDependencies
RUN npm ci --only=production

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
