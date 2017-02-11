# Build: docker build -f node.dockerfile -t danwahlin/node .

# Option 1
# Start MongoDB and Node (link Node to MongoDB container with legacy linking)
 
# docker run -d --name my-mongodb mongo
# docker run -d -p 3000:3000 --link my-mongodb:mongodb --name nodeapp danwahlin/node

# Option 2: Create a custom bridge network and add containers into it

# docker network create --driver bridge isolated_network
# docker run -d --net=isolated_network --name mongodb mongo
# docker run -d --net=isolated_network --name nodeapp -p 3000:3000 danwahlin/node

# Seed the database with sample database
# Run: docker exec nodeapp node dbSeeder.js

# Use the latest NodeJS version for this image
FROM node:latest
MAINTAINER Bill Bensing

# Set container environment variables so ExpressSite can use these
ENV NODE_ENV="development" PORT=3000

# Copy all files from locaal directory into volume directory '/var/www' of image
COPY . /var/www

# Set working directory of the image
WORKDIR /var/www

# Install NPM dependenceis once image is running as a container
RUN npm install && node dbSeeder.js

#Let DockerEngine communicate with app on this port; uses port set in Environment Variable $PORT
EXPOSE $PORT

# Enter the application using the '$npm start' command 
ENTRYPOINT ["npm","start"]