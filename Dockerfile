FROM --platform=linux/amd64 ruby:3.1-bookworm
# Set the working directory in the container to /app
WORKDIR /src

# Add metadata to the image to describe which port the container is listening on at runtime
EXPOSE 3000

# Copy the Gemfile and Gemfile.lock into the image
# COPY Gemfile Gemfile.lock ./

# Install any needed packages specified in Gemfile
# RUN bundle install

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Provide a default command to run when the container starts
