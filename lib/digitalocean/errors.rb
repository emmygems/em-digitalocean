module Digitalocean
  # Base Error
  class Error < RuntimeError
    attr_accessor :code

    def initialize(data=nil)
      @message = case data
      when Hash
        @code    = data[:code]
        data[:message]
      else
        data
      end
    end

    def message
      code ? "(#{code}) #{@message}" : @message
    end

    def to_s
      message
    end
  end

  # Internal Server Error
  class ServerError < Error
  end

  class ClientError < Error
    attr_accessor :id

    def initialize(response)
      @message = response.json["message"]
      @id      = response.json["id"]
      @code    = response.status
    rescue StandardError
      @message = "Uncatched Error"
    end
  end

  #<<<
end
