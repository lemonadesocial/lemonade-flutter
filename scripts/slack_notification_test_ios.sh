#!/bin/bash

export SLACK_WEBHOOK_URL="PROVIDE_YOUR_SLACK_WEBHOOK_HERE"
export CM_PROJECT_ID="project_1"
export CM_BUILD_ID="build_1"
export CM_REPO_SLUG="repo_slug"
export CM_PULL_REQUEST_NUMBER="pull_1"
export CM_BRANCH="branch_1"
export CM_COMMIT="commit_1"
export ARTIFACT_URL="artifact_url_1"

payload='{
  "attachments": [
    {
      "blocks": [
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": ":white_check_mark: Staging app build successful for iOS"
          }
        },
        {
          "type": "section",
          "fields": [
            {
              "type": "mrkdwn",
              "text": "*Build Link*:\n<https://codemagic.io/app/'"$CM_PROJECT_ID"'/build/'"$CM_BUILD_ID"'|Click here>"
            },
            {
              "type": "mrkdwn",
              "text": "*Pull Request*:\n<https://github.com/'"$CM_REPO_SLUG"'/pull/'"$CM_PULL_REQUEST_NUMBER"'|Open pull request>"
            }
          ]
        },
        {
          "type": "section",
          "fields": [
            {
              "type": "mrkdwn",
              "text": "*Branch*\n'"$CM_BRANCH"'"
            },
            {
              "type": "mrkdwn",
              "text": "*Commit*\n'"$CM_COMMIT"'"
            }
          ]
        },
        {
          "type": "actions",
          "elements": [
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "Download on TestFlight"
              },
              "url": "itms-beta://beta.itunes.apple.com/v1/app/6450680676"
            }
          ]
        }
      ]
    }
  ]
}'

curl -0 -v -X POST $SLACK_WEBHOOK_URL \
  -H 'Content-type: application/json' \
  --data-raw "$payload"
