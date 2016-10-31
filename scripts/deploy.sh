#!/bin/sh

set -e

export MIX_ENV=prod
mix release --env=prod
scp rel/codetogether/releases/0.0.1/codetogether.deb "$DEPLOYER@$SERVER":codetogether.deb
ssh "$DEPLOYER@$SERVER" 'dpkg -i codetogether.deb'
