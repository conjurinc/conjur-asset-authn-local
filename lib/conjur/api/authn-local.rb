#
# Copyright (C) 2016 Conjur Inc
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require 'conjur/api/authn'

module Conjur
  class API
    AUTHN_LOCAL_SOCKET = '/run/authn-local/.socket'

    class << self
      alias authenticate_remote authenticate
      
      # Perform local authentication on the Conjur appliance.
      #
      # This method connects to the `conjur-authn-local` service using a Unix socket, writes the 
      # username and gets back a Conjur bearer token.
      def authenticate_local username
        require 'json'
        require 'socket'
        if Conjur.log
          Conjur.log << "Authenticating #{username} with authn-local\n"
        end
        JSON.parse(UNIXSocket.open(AUTHN_LOCAL_SOCKET) {|s| s.puts username; s.gets })
      end
      
      # Authenticates locally if the mechanism is available and enabled. Otherwise, authenticates
      # using the standard `conjur-authn` HTTP service.
      def authenticate username, password = nil
        if authenticate_locally?
          authenticate_local username
        else
          authenticate_remote username, password
        end
      end
      
      private
      
      def authenticate_locally?
        Conjur.configuration.use_authn_local && File.exists?(AUTHN_LOCAL_SOCKET)
      end      
    end
  end
end
