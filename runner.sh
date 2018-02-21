#!/bin/sh

if [ ! -f "${CI_PROJECT_DIR}/sonar-project.properties" ]; then
  echo "Please add a sonar-project.properties to scan this project"
  exit(1)
fi

/root/sonar-scanner/bin/sonar-scanner \
  -Dsonar.gitlab.api_version=v4 \
  -Dsonar.host.url=$SONAR_SERVER \
  -Dsonar.login=$SONAR_LOGIN \
  -Dsonar.analysis.mode=preview \
  -Dsonar.gitlab.commit_sha=$CI_COMMIT_REF \
  -Dsonar.gitlab.ref_name=$CI_COMMIT_REF_NAME \
  -Dsonar.gitlab.project_id=$CI_PROJECT_ID \
  -Dsonar.projectKey=$CI_PROJECT_ID
