#!/bin/sh

# Loading environment variables from .env and friends
source /lagoon/entrypoints/50-dotenv.sh

# Generate some additional enviornment variables
source /lagoon/entrypoints/55-generate-env.sh

echo "$LAGOON_ENVIRONMENT_TYPE: Ghost is starting"

node current/index.js
