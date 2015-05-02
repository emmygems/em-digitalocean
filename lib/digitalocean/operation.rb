module Digitalocean
  class Operation
    using EventObject

    attr_accessor :api
    attr_accessor :request    # EmmyHttp::Client::Request
    attr_accessor :operation  # EmmyHttp::Client::Operation

    events :success, :error

    def initialize(api, request)
      @api = api
      @request = request
      auth
      new_operation
    end

    def connect(*a)
      operation.connect(*a)
    end

    def sync
      connect

      Fiber.sync do |f|
        on :success do |response, operation, conn|
          f.resume response.json(symbolize_names: true)
        end

        on :error do |error, operation, conn|
          f.leave error
        end
      end
    end

    def to_a
      operation.to_a
    end

    protected

    def auth
      if api.token
        request.headers["Authorization"] = "Bearer #{api.token}"
      elsif api.user && api.password
        request.user = api.user
        request.password = api.password
      end
    end

    def new_operation
      @operation = request.new_operation
      @operation.on :success do |res, op, conn|
        # success
        case res.status
        when 200...300
          success!(res, self, conn)
        when 400...500
          error!(Digitalocean::ClientError.new(res), self, conn)
        else
          error!(Digitalocean::ServerError.new({message: "Internal Server Error", code: res.status}), self, conn)
        end
      end

      @operation.on :error do |message, op, conn|
        # error
        error!(message, self, conn)
      end
    end

    #<<<
  end
end
