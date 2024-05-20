ARG RUBY_VERSION
FROM --platform=linux/amd64 ruby:${RUBY_VERSION}
ARG RAILS_VERSION

# Set the working directory in the container to /app
WORKDIR /src

# Add metadata to the image to describe which port the container is listening on at runtime
EXPOSE 3000

COPY ./gemfiles ./gemfiles
COPY civis-authority.gemspec .
COPY ./lib/authority/version.rb ./lib/authority/version.rb


RUN cp ./gemfiles/${RAILS_VERSION}.gemfile ./Gemfile && \
    sed -i -e '$ d' './Gemfile' && \
    echo "gemspec" >> ./Gemfile && \
    bundle install

COPY . .

