#!/usr/bin/env bash

set -e
set -o pipefail
set -u

export PROJECT_ID=dataflow-415114
export LOCATION=europe-west1

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
