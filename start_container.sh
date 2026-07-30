#!/bin/bash

# Function to validate semantic version string
validate_version() {
    if ! echo "$1" | grep -q -E '^[0-9]+(\.[0-9]+){0,2}$'; then
        INVALID_VERSIONS+="$1 "
    fi
}

# Initialize our own variables
RUBY_VERSION=""
RAILS_VERSION=""
BUILD=""
COMMAND=""
INVALID_VERSIONS=""

# Check if .env file exists
if [ -f ".env" ]; then
    source .env
    # Validate versions
    validate_version "$RUBY_VERSION"
    validate_version "$RAILS_VERSION"
fi

# Parse command line options
while (( "$#" )); do
  case "$1" in
    --ruby)
      # Validate version
      validate_version "$2"
      RUBY_VERSION="$2"
      shift 2
      ;;
    --rails)
      # Validate version
      validate_version "$2"
      RAILS_VERSION="$2"
      shift 2
      ;;
    --build)
      BUILD="--build"
      shift
      ;;
    --command)
      COMMAND="$2"
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

# Check if there are any invalid versions
if [ -n "$INVALID_VERSIONS" ]; then
    echo "Error: Invalid version strings: $INVALID_VERSIONS"
    exit 1
fi

# Check if Ruby and Rails versions are provided
if [ -z "$RUBY_VERSION" ] || [ -z "$RAILS_VERSION" ]; then
    echo "You must enter Ruby and Rails versions with --ruby and --rails options or have a .env file in the root of the repo."
    exit 1
fi

# Set the environment variables
export RUBY_VERSION
export RAILS_VERSION

# Output the Ruby and Rails versions
echo "Using Ruby version: $RUBY_VERSION"
echo "Using Rails version: $RAILS_VERSION"

# Run the Docker Compose command
docker-compose up -d $BUILD

# The container bind-mounts the repo over /src, which hides the Rails-version-pinned
# Gemfile the Dockerfile generated at build time. Pin BUNDLE_GEMFILE explicitly so the
# running container actually tests against gemfiles/$RAILS_VERSION.gemfile instead of
# silently falling back to the unversioned root Gemfile.
BUNDLE_GEMFILE="/src/gemfiles/${RAILS_VERSION}.gemfile"
if [ ! -f "./gemfiles/${RAILS_VERSION}.gemfile" ]; then
    echo "Error: Gemfile not found for Rails ${RAILS_VERSION}: ./gemfiles/${RAILS_VERSION}.gemfile" >&2
    exit 1
fi

# Check if COMMAND is set
if [ -n "$COMMAND" ]; then
    docker-compose exec -e BUNDLE_GEMFILE="$BUNDLE_GEMFILE" app bash -c "$COMMAND"
else
    docker-compose exec -e BUNDLE_GEMFILE="$BUNDLE_GEMFILE" app bash
fi
