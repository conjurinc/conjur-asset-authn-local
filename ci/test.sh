#!/bin/bash -e

cd /src/conjur-asset-authn-local

bundle

# If the authn-local socket isn't up bug out
if [ ! -e /run/authn-local/.socket ] ; then
    echo "Authn local socket is missing!"
    exit 1
fi

bundle exec rake jenkins || true
