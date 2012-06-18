require "open-uri"
require "json"
require "faraday"
require "faraday_middleware"

require "jsonapi/tokenizable"
require "jsonapi/version"

# Docs go here for overall module.
module JSONAPI
  # Docs go here for API adapter class.
  class JSONAPI
    include Tokenizable

    attr_accessor  :username, :password, :host, :port, :token, :salt

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
      @salt = opts[:salt]

      yield(self) if block

      generate_methods if @username and @password
    end

    def call_api(method, *args)
      key = tokenize(@username, method, @password, @salt)
      connection.get "/api/call", :method => method, :key => key
    end

    private

    def connection
      @conection ||= ::Faraday.new(:url => "http://#{@host}:#{@port}") do |builder|
        builder.request  :url_encoded
        # builder.response :logger
        builder.response :json
        builder.adapter  :net_http
      end
    end

    def generate_methods
      files = self.call_api 'getPluginFiles', 'JSONAPI'
    end

  end
end
