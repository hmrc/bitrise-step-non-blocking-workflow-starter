#!/bin/bash
set -ex

start_workflow() {
    STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" \
        https://app.bitrise.io/app/$BITRISE_APP_SLUG/build/start.json \
        --data '{"hook_info":{"type":"bitrise","build_trigger_token":"'"$BITRISE_BUILD_TRIGGER_TOKEN"'"},"build_params":{"branch":"'"$BITRISE_GIT_BRANCH"'","commit_hash":"'"$BITRISE_GIT_COMMIT"'","workflow_id":"'"$1"'"},"triggered_by":"curl"}' \
    )
    if (($STATUSCODE >= 200 && $STATUSCODE < 300)); then
        echo "Started the workflow: ${1}"
    else
        echo "Failed to start workflow: ${1}"
        exit 1
    fi
}

pending_health_check() {
    # setup health check with Github API
    STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" \
        -X POST -H 'Accept: application/vnd.github.v3+json' \
        -H 'Authorization: token '"$GITHUB_TOKEN"'' https://api.github.com/repos/hmrc/$REPO_NAME/statuses/$BITRISE_GIT_COMMIT \
        -d '{"state":"pending", "target_url": "https://app.bitrise.io/build/'"$1"'", "description": "Pending - '"$BITRISEIO_GIT_REPOSITORY_SLUG"'", "context": "ci/bitrise/'"$BITRISE_GIT_BRANCH"'/'"$1"'"}' \
    )
    if (($STATUSCODE >= 200 && $STATUSCODE < 300)); then
        echo "Updated status for workflow: ${1}"
    else
        echo "Failed to update status for workflow: ${1}"
        exit 1
    fi
}

# Split string into an array using a single space as the delimiter
FLOWS=(${step_workflows// / })

for i in "${FLOWS[@]}"
do
    start_workflow $i
    
    pending_health_check $i
done