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
esac

