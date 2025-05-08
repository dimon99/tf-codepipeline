#!/bin/bash

# Required environment variables:
# GITHUB_TOKEN: Your GitHub personal access token
# GITHUB_REPO: repository in format "owner/repo"
# PR_NUMBER: Pull request number
# COMMENT_MESSAGE: The message to post for PR

set +x

if [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_REPO" ] || [ -z "$PR_NUMBER" ] || [ -z "$COMMENT_MESSAGE" ]; then
    echo "Error: Required environment variables are not set"
    echo "Please set: GITHUB_TOKEN, GITHUB_REPO, PR_NUMBER, COMMENT_MESSAGE"
    exit 1
fi

# Create the JSON payload
json_payload=$(cat << EOF
{
  "body": "$COMMENT_MESSAGE"
}
EOF
)

# Make the API request
response=$(curl -s -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Content-Type: application/json" \
    "https://api.github.com/repos/$GITHUB_REPO/issues/$PR_NUMBER/comments" \
    -d "$json_payload")

# Check if the request was successful
if echo "$response" | grep -q "created_at"; then
    echo "Successfully added comment to PR #$PR_NUMBER"
else
    echo "Error adding comment to PR"
    echo "Response: $response"
    exit 1
fi
