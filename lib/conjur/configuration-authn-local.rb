module Conjur
  class Configuration
    # If true (the default), use authn-local if it's available
    # (indicated by the existence of its socket). Otherwise,
    # authenticate with authn.
    add_option :use_authn_local, default: true
  end
end