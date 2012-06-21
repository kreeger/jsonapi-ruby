require 'logger'
require 'jsonapi'

class Dummy; end

RSpec.configure do |c|
  c.before(:each) do
    @logger = ::Logger.new(STDOUT)
  end
end

RSpec::Matchers.define :end_with do |end_str|
  match { |actual| actual.end_with?(end_str) }
end

RSpec::Matchers.define :begin_with do |begin_str|
  match { |actual| actual.start_with?(begin_str) }
end

RSpec::Matchers.define :contain do |contain_str|
  match { |actual| actual.include?(contain_str) }
end
