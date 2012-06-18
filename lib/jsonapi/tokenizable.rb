require 'digest/sha2'

module JSONAPI
  # Includes functionality for tokenizing stuff.
  module Tokenizable

    # A wrapper around stdlib's `Digest::SHA256`. Given an array of strings,
    # joins them and generates a token.
    #
    # @param [Array] args an array of strings.
    #
    # @return [String] a token representation of the strings given.
    def tokenize(*args)
      Digest::SHA256.hexdigest args.map(&:to_s).join
    end

    def random_string(length=8)
      (0...length).map{65.+(rand(25)).chr}.join
    end
  end
end
