require 'spec_helper'

describe JSONAPI do
  describe JSONAPI do
    let(:this) { JSONAPI::JSONAPI }
    let(:args) do
      { :username => 'user', :password => 'secret', :host => 'urmom.com', :port => '20058' }
    end

    it 'should instantiate' do
      proc { this.new }.should_not raise_error
    end

    it 'should take a username, password, etc.' do
      api = this.new(args)
      args.each { |arg, val| api.send(arg).should == val }
    end

    it 'should also use a block' do
      api = this.new do |a|
        a.username = args[:username]
        a.password = args[:password]
        a.host = args[:host]
        a.port = args[:port]
      end

      args.each { |arg, val| api.send(arg).should == val }
    end

  end
end
