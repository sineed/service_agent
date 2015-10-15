module ServiceAgent
  class NotificationServices
    include Enumerable

    attr_reader :services

    def initialize(services)
      @services = []
    end

    def each
      services.each { |service| yield service }
    end

    def succeed(response_code)
      each { |service| service.succeed(response_code) }
    end

    def failed(response_code)
      each { |service| service.failed(response_code) }
    end

    def restored(response_code)
      each { |service| service.restored(response_code) }
    end

    def disaster
      each(&:disaster)
    end

    def register(service)
      services.push(service)
    end
  end
end
