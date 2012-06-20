require "open-uri"
require "json"
require "faraday"
require "faraday_middleware"

require "jsonapi/tokenizable"
require "jsonapi/version"
require "jsonapi/errors"

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
      json_args = Array(args).to_json
      begin
        result = connection.get "/api/call", :method => method, :args => json_args, :key => key
        raise ApiError.new(result) unless result.status == 200
        result.body['success']
      rescue ApiError => e
        puts "Encountered error #{e.result.status}."
      end
    end

    private

    def connection
      @conection ||= ::Faraday.new(:url => "http://#{@host}:#{@port}") do |builder|
        builder.request  :url_encoded
        # builder.response :logger
        builder.response :json
        # builder.response :mashify
        builder.adapter  :net_http
      end
    end

    def generate_methods
      # Get all files related to JSONAPI.
      files = self.call_api 'getPluginFiles', 'JSONAPI'
      # Get all plugins on the server.
      plugins = self.call_api 'getPlugins'
      # For each .json API file...
      files.select { |f| File.extname(f) == '.json' }.each do |file|
        # Read in the file config.
        contents = self.call_api 'getFileContents', file
        config = JSON.parse contents
        enabled = true
        config['depends'].each do |dependency|
          plugin = plugins.find { |p| p['name'] == dependency && p['enabled'] }
          enabled = !plugin.nil?
        end

        config['methods'].each do |method|
          method['namespace'] = config['namespace']
          method['enabled'] = enabled

        end
      end
    end

  end
end
