#!/usr/bin/env bash

set -e
set -o pipefail
set -u

export PROJECT_ID=dataflow-415114
export LOCATION=europe-west4

export REPO_NAME=internal-images
export IMAGE_NAME="dataflow/team-league-java"
export IMAGE_TAG=latest
export METADATA_FILE="config/metadata.json"
export METADATA_TEMPLATE_FILE_PATH="gs://amokrane-dataflow-examples/dataflow/templates/team_league/java/team-league-java.json"
export SDK_LANGUAGE=JAVA
export FLEX_TEMPLATE_BASE_IMAGE=JAVA11
export JAR=target/teams-league-0.1.0.jar
export FLEX_TEMPLATE_JAVA_MAIN_CLASS="fr.groupbees.application.TeamLeagueApp"
export JOB_NAME="team-league-java"

export TEMP_LOCATION="gs://amokrane-dataflow-examples/dataflow/temp"
export STAGING_LOCATION="gs://amokrane-dataflow-examples/dataflow/staging"
export SA_EMAIL="sa-dataflow-dev@dataflow-415114.iam.gserviceaccount.com"
export INPUT_FILE="gs://amokrane-dataflow-examples/team_league/input/json/input_teams_stats_raw.json"
export SIDE_INPUT_FILE="gs://amokrane-dataflow-examples/team_league/input/json/input_team_slogans.json"
export TEAM_LEAGUE_DATASET=amokrane_test
export TEAM_STATS_TABLE=team_stat
export JOB_TYPE=team_league_java_ingestion_job
export FAILURE_OUTPUT_DATASET=amokrane_test
export FAILURE_OUTPUT_TABLE=job_failure
export FAILURE_FEATURE_NAME=team_league

export PROJECT_ID=dataflow-415114
export LOCATION=europe-west1

export REPO_NAME=internal-images
export IMAGE_NAME="dataflow/team-league-python"
export IMAGE_TAG=latest
export METADATA_FILE="config/metadata.json"
export METADATA_TEMPLATE_FILE_PATH="gs://amokrane-dataflow-examples/dataflow/templates/team_league/python/team-league-python"
export SDK_LANGUAGE=PYTHON
export JOB_NAME="team-league-python"
export TEMP_LOCATION="gs://amokrane-dataflow-examples/dataflow/temp"
export STAGING_LOCATION="gs://amokrane-dataflow-examples/dataflow/staging"

export SA_EMAIL="sa-dataflow-dev@dataflow-415114.iam.gserviceaccount.com"
export INPUT_FILE="gs://amokrane-dataflow-examples/team_league/input/json/input_teams_stats_raw.json"
export SIDE_INPUT_FILE="gs://amokrane-dataflow-examples/team_league/input/json/input_team_slogans.json"
export TEAM_LEAGUE_DATASET=amokrane_test
export TEAM_STATS_TABLE=team_stat

gcloud beta builds triggers create manual \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --name="deploy-dataflow-template-team-league-python-dockerfile" \
    --repo="https://github.com/AmokraneMancer/dataflow-python-ci-cd" \
    --repo-type="GITHUB" \
    --branch="main" \
    --build-config="dataflow-deploy-template-dockerfile-all-dependencies.yaml" \
    --substitutions _REPO_NAME="internal-images",_IMAGE_NAME="dataflow/team-league-python",_IMAGE_TAG="latest",_METADATA_TEMPLATE_FILE_PATH=$METADATA_TEMPLATE_FILE_PATH,_SDK_LANGUAGE=$SDK_LANGUAGE,_METADATA_FILE=$METADATA_FILE \
    --verbosity="debug"


  gcloud beta builds triggers create github \
      --project=$PROJECT_ID \
      --region=$LOCATION \
      --name="launch-dataflow-unit-tests-team-league-python" \
      --repo-name=dataflow-python-ci-cd \
      --repo-owner=AmokraneMancer \
      --branch-pattern=".*" \
      --build-config=dataflow-run-tests.yaml \
      --include-logs-with-status \
      --verbosity="debug"

  gcloud beta builds triggers create manual \
      --project=$PROJECT_ID \
      --region=$LOCATION \
      --name="run-dataflow-template-team-league-python" \
      --repo="https://github.com/AmokraneMancer/dataflow-python-ci-cd" \
      --repo-type="GITHUB" \
      --branch="main" \
      --build-config="dataflow-run-template.yaml" \
      --substitutions _JOB_NAME=$JOB_NAME,_METADATA_TEMPLATE_FILE_PATH=$METADATA_TEMPLATE_FILE_PATH,_TEMP_LOCATION=$TEMP_LOCATION,_STAGING_LOCATION=$STAGING_LOCATION,_SA_EMAIL=$SA_EMAIL,_INPUT_FILE=$INPUT_FILE,_SIDE_INPUT_FILE=$SIDE_INPUT_FILE,_TEAM_LEAGUE_DATASET=$TEAM_LEAGUE_DATASET,_TEAM_STATS_TABLE=TEAM_STATS_TABLE \
      --verbosity="debug"