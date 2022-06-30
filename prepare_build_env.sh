#!/bin/bash

set -euo pipefail

echo "Invoked with=> CI_PIPELINE_SOURCE-> $CI_PIPELINE_SOURCE, CI_COMMIT_TAG-> $CI_COMMIT_TAG"

# This is API URL to access parent (infra) project
INFRA_PROJECT_API="${CI_API_V4_URL}/projects/$(echo $INFRA_PROJECT_PATH |sed -e 's|/|%2F|g')/jobs/artifacts/master/download"

# Download artifact with k8s cluster config and other info variables
wget --header "JOB-TOKEN:$CI_JOB_TOKEN" ${INFRA_PROJECT_API}?job=${INFRA_ARTIFACT_SOURCE_JOB} -O .artifacts.zip
unzip .artifacts.zip && rm -f .artifacts.zip

# secure files with credentials
chmod 0600 admin-*.conf infra-info.yaml

# Assign info variables extracted from artifact
CONTAINER_REGISTRY=$(grep '^container_registry:' infra-info.yaml |cut -f2 -d' ')
DOCKER_REGISTRY_KEY=$(grep '^docker_registry_agent_key:' infra-info.yaml |cut -f2 -d' ' |base64 -d)
DEPLOY_ENV_INHERITED=$(grep '^deploy_env:' infra-info.yaml |cut -f2 -d' ')
export CONTAINER_REGISTRY DOCKER_REGISTRY_KEY DEPLOY_ENV_INHERITED


# Determine deploy environment (prod/stage)
# by default, DEPLOY_ENV is 'stage'
export DEPLOY_ENV=stage

# if deployment called from infra project, will use inherited cluster value
if [ "$CI_PIPELINE_SOURCE" = "pipeline" ]; then
  export DEPLOY_ENV=$DEPLOY_ENV_INHERITED
fi

# if it tag release, then DEPLOY_ENV is 'prod'
if [ -n "$CI_COMMIT_TAG" ]; then
  export DEPLOY_ENV=prod
fi

# but we always can reassign this behaviour with USE_DEPLOY_ENV CI env
if [ -n "$USE_DEPLOY_ENV" ]; then
  export DEPLOY_ENV=$USE_DEPLOY_ENV
fi

# if DEPLOY_ENV is 'prod' but no tag release, checkout the latest tag to have the stable application build
if [ "$DEPLOY_ENV" = "prod" ] && [ -z "$CI_COMMIT_TAG" ]; then
    last_tag=$(git tag -l --sort="version:refname" |tail -1)
    git checkout $last_tag
    export CI_COMMIT_TAG=$last_tag
fi

echo "Invoked with=> DEPLOY_ENV_INHERITED-> $DEPLOY_ENV_INHERITED, DEPLOY_ENV-> $DEPLOY_ENV, CI_COMMIT_TAG-> $CI_COMMIT_TAG"
