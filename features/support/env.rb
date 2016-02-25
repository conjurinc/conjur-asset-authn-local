require 'conjur/cli'
require 'conjur-api'
require 'conjur-asset-authn-local'

Conjur::Config.load
Conjur::Config.apply
