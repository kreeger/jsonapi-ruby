module JSONAPI

  class ApiError < Exception
    attr_accessor :result

    def initialize(result)
      @result = result
    end
  end

end
