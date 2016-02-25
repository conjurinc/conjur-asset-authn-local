#!/bin/bash -e

cd /src/conjur-asset-authn-local

bundle
bundle exec rake jenkins || true
