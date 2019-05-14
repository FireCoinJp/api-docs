#!/bin/sh

case $1 in
    init)
        bundle config build.nokogiri --use-system-libraries
        bundle install
        ;;
    start)
        bundle exec middleman server
        ;;
    build)
        ./deploy.sh
        ;;
    localBuild)
        ./deploy.sh -v --source-only
        ;;
    deploy)
        ./deploy.sh -v --source-only
        aws --profile=compliance-s3 s3 sync build s3://local-jp-api-docs --exclude=.git

        ;;

esac

