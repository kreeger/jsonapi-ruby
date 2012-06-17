require 'logger'
require 'jsonapi'

class Dummy; end

RSpec.configure do |c|
  c.before(:each) do
    @logger = ::Logger.new(STDOUT)
  end
end
