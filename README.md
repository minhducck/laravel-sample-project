# Sample Laravel Project

![CI Badge](https://github.com/minhducck/laravel-sample-project/actions/workflows/laravel-static-check.yml/badge.svg?branch=main)
![Code Coverage](https://raw.githubusercontent.com/minhducck/laravel-sample-project/image-data/coverage.svg) [Coverage Report](https://duckonemorec.me/laravel-sample-project/)

## Installation steps

### Prerequisites
> OS: Ubuntu 24.04 LTS
> 
> nginx/1.24.0 (Ubuntu)
> 
> PHP 8.1.x ( xdebug available - for coverage )
> PHP-FPM 8.1
>
> MariaDB 10.x
> 
> Composer version 2.x


[!IMPORTANT] Please upload setup `scripts` folder to server before execute the following steps. 

### Create web user
```shell
#example user: runner.

sudo bash ./scripts/create-web-user.sh runner;
```

### Install NGINX/PHP-FPM/MariaDB
```shell
#!/usr/bin/env bash
export WEB_USER=runner; # PLEASE CHANGE
export WEB_DOMAIN=laravel.duckonemorec.me; # PLEASE CHANGE

sudo bash ./scripts/install-packages.sh \ 
&& sudo bash ./scripts/configure-nginx.sh $WEB_USER $WEB_DOMAIN \
&& sudo bash ./scripts/configure-fpm.sh $WEB_USER \
&& sudo bash ./scripts/tuning.sh $WEB_USER
``` 
[!IMPORTANT] Please change default password for root inside `mysql_root_setup.sql`

[!IMPORTANT] Please create a MYSQL USER, PASSWORD, and database for production.

### Setup for CI/CD
#### Create self-hosted runner
> Go to github repository Setting > Actions > Runners > New self-hosted runner and following provided steps

```shell
#!/bin/bash
export RUNNER_USER=runner;
export GITHUB_ACTION_TOKEN=ABSURTEBKPG65Y4PSWFRYB3GPVDVG

sudo bash ./scripts/create-web-user.sh $RUNNER_USER;
sudo bash ./scripts/install-docker.sh $RUNNER_USER;
sudo bash ./scripts/setup-self-host-runner.sh $RUNNER_USER $GITHUB_ACTION_TOKEN;
cd /home/$RUNNER_USER/actions-runner/;
sudo ./svc.sh install $RUNNER_USER
sudo ./svc.sh start 
```

### Prepare env files on server:
> Files:
>> 1. /home/runner/envs/.env
>> 2. /home/runner/envs/.env.main.ci
>> 3. /home/runner/envs/phpunits/phpunit-main.xml

#### Adding environment on Github Repository
> Go to github repository Setting > Secrets and variables > Actions
>
> Create following variable:
>> Secrets:
>> 1. CI_MYSQL_PASSWORD (UnitTest MySQL Password)
>> 2. CI_MYSQL_USER     (UnitTest MYSQL User)
>> 3. DEPLOY_DIR        (Production directory)
>> 4. ENV_PATH          (.env file path for production eg: )
>> 5. CUSTOM_GITHUB_TOKEN ( set for composer package )


### Create Webroot and Clone project for first time
The webroot must link to `{{github.secrets.DEPLOY_DIR}}` and in the setup will be `/home/runner/www/laravel-sample-project`

```shell
#!/usr/bin/env bash
mkdir -p /home/runner/www/laravel-sample-project && cd /home/runner/www/laravel-sample-project;
git clone https://github.com/minhducck/laravel-sample-project.git --branch main --single-branch ./
```

### 
