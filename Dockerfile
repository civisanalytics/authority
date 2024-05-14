ARG RUBY_VERSION
FROM --platform=linux/amd64 ruby:${RUBY_VERSION}
ARG RAILS_VERSION

# Set the working directory in the container to /app
WORKDIR /src

# Add metadata to the image to describe which port the container is listening on at runtime
EXPOSE 3000

COPY . .

RUN cd ./gemfiles && \
    cp ./${RAILS_VERSION}.gemfile ./Gemfile && \
    bundle install
