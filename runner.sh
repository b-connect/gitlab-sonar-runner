#!/bin/sh

if [ -z ${SONAR_URL+x} ]; then
  echo "Undefined \"SONAR_URL\" env" && exit 1
fi

if [ ! -f "${CI_PROJECT_DIR}/sonar-project.properties" ]; then
  echo "Please add a sonar-project.properties to scan this project"
  exit 1
fi

if [ -z ${SONAR_ANALYSIS_MODE+x} ]; then
  SONAR_ANALYSIS_MODE="preview"
fi

COMMAND="/root/sonar-scanner/bin/sonar-scanner -Dproject.settings=${CI_PROJECT_DIR}/sonar-project.properties -Dsonar.host.url=$SONAR_URL"

if [ -z ${SONAR_PROJECT_KEY+x} ]; then
  SONAR_PROJECT_KEY=$CI_PROJECT_PATH_SLUG
fi

if [ -z ${SONAR_PROJECT_VERSION+x} ]; then
  SONAR_PROJECT_VERSION=$CI_BUILD_ID
fi

if [ -z ${SONAR_GITLAB_PROJECT_ID+x} ]; then
  SONAR_GITLAB_PROJECT_ID=$CI_PROJECT_ID
fi

if [ ! -z ${SONAR_TOKEN+x} ]; then
  COMMAND="$COMMAND -Dsonar.login=$SONAR_TOKEN"
fi

if [ ! -z ${SONAR_PROJECT_VERSION+x} ]; then
  COMMAND="$COMMAND -Dsonar.projectVersion=$SONAR_PROJECT_VERSION"
fi

if [ ! -z ${SONAR_GITLAB_URL+x} ]; then
  COMMAND="$COMMAND -Dsonar.gitlab.url=$SONAR_GITLAB_URL"
fi


if [ ! -z ${SONAR_DEBUG+x} ]; then
  COMMAND="$COMMAND -X"
fi

COMMAND="$COMMAND -Dsonar.projectKey=${SONAR_PROJECT_KEY} "

COMMAND="$COMMAND -Dsonar.analysis.mode=$SONAR_ANALYSIS_MODE"

COMMAND="$COMMAND -Dsonar.issuesReport.console.enable=true"

if [ ! -z ${SONAR_GITLAB_PROJECT_ID+x} ]; then
  COMMAND="$COMMAND -Dsonar.gitlab.project_id=$SONAR_GITLAB_PROJECT_ID"
fi

if [ ! -z ${SONAR_GITLAB_TOKEN+x} ]; then
  COMMAND="$COMMAND -Dsonar.gitlab.user_token=$SONAR_GITLAB_TOKEN"
fi

if [ ! -z ${CI_BUILD_REF+x} ]; then
  COMMAND="$COMMAND -Dsonar.gitlab.commit_sha=$CI_BUILD_REF"
fi

if [ ! -z ${CI_BUILD_REF_NAME+x} ]; then
  COMMAND="$COMMAND -Dsonar.gitlab.ref_name=$CI_BUILD_REF_NAME"
fi


cd $CI_PROJECT_DIR
$COMMAND