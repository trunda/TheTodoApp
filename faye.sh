#!/usr/bin/env bash

BASEDIR=$(dirname $0)
BUNDLE_GEMFILE=$BASEDIR/Gemfile

bundle exec rackup $BASEDIR/faye.ru -s thin -E development