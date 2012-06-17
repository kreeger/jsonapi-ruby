require "jsonapi/tokenizable"
require "jsonapi/version"

# Docs go here for overall module.
module JSONAPI
  # Docs go here for API adapter class.
  class JSONAPI
    include Tokenizable

    attr_accessor :username, :password, :host, :port
    attr_reader :token, :salt

    # Initialize method.
    def initialize(args={}, &block)
      opts = {
        :host => 'localhost',
        :port => '20059'
      }.merge(args)

      @username = opts[:username]
      @password = opts[:password]
      @host = opts[:host]
      @port = opts[:port]

      yield(self) if block

      @salt = random_string
    end
  end
end
