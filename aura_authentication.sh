#!/bin/sh

set -e

eval "$(jq -r '@sh "CLIENT_ID=\(.client_id) CLIENT_SECRET=\(.client_secret)"')"

curl --no-progress-meter \
     --request POST 'https://api.neo4j.io/oauth/token' \
     --user ''"$CLIENT_ID"':'"$CLIENT_SECRET"'' \
     --header 'Content-Type: application/x-www-form-urlencoded' \
     --data-urlencode 'grant_type=client_credentials' \
| jq '{access_token}'
