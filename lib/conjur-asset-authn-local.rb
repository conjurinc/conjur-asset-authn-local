require "conjur-asset-authn-local-version"
require 'conjur/api/authn-local'
require 'conjur/configuration-authn-local'

module Conjur
  class API
    class << self
      # Allow the API key to be nil.
      def new_from_key(username, api_key = nil, remote_ip = nil)
        self.new.init_from_key(username, api_key || "api-key-is-not-required-for-local-authentication", remote_ip)
      end
    end
  end
end

if defined?(Conjur::Authn) && Conjur::Authn.respond_to?(:env_credentials)
  module Conjur
    module Authn
      class << self
        alias default_env_credentials env_credentials
        def env_credentials
          if Conjur.configuration.use_authn_local && File.exists?(Conjur::API::AUTHN_LOCAL_SOCKET) && (login = ENV['CONJUR_AUTHN_LOGIN'])
            [login]
          else
            default_env_credentials
          end
        end
      end
    end
  end
end
