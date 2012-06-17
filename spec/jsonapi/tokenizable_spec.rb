require 'spec_helper'

describe JSONAPI::Tokenizable do
  let(:this) { Dummy.new.extend JSONAPI::Tokenizable }

  describe :tokenize do
    it 'should handle a blank argument list' do
      proc { this.tokenize }.should_not raise_error
    end

    it 'should return a tokenized string' do
      result = this.tokenize 'i', 'am', 'your', 'father'
      result.length.should > 32
    end
  end

  describe :random_string do
    it 'should generate a random string' do
      this.random_string.length.should == 8
    end

    it 'should take and generate strings of varying length' do
      this.random_string(16).length.should == 16
      this.random_string(64).length.should == 64
    end
  end
end
