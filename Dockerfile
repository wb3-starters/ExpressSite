# Use the latest NodeJS version for this image
FROM node:latest
MAINTAINER Bill Bensing

# Set container environment variables so ExpressSite can use these
ENV NODE_ENV=production
ENV PORT=3000

# Copy all files from locaal directory into volume directory '/var/www' of image
COPY . /var/www

# Set working directory of the image
WORKDIR /var/www

# Identify a custom volume for this image; source code will live in this volume
VOLUME ["/var/www"]

# Install NPM dependenceis once image is running as a container
RUN npm install

#Let DockerEngine communicate with app on this port; uses port set in Environment Variable $PORT
EXPOSE $PORT

# Enter the application using the '$npm start' command 
ENTRYPOINT ["npm","start"]