#!/usr/bin/env bash
RUNNER_USER=$1;
GITHUB_ACTION_TOKEN=$2

cd /home/$RUNNER_USER/;
rm -rf actions-runner;
mkdir actions-runner && cd actions-runner;
curl -o actions-runner-linux-x64-2.317.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz || exit 1;
tar xzf ./actions-runner-linux-x64-2.317.0.tar.gz || exit 1;

sudo -u $RUNNER_USER bash -c './config.sh --unattended --url https://github.com/minhducck/laravel-sample-project --token '$GITHUB_ACTION_TOKEN' --labels "digital-ocean"' || exit 1;
