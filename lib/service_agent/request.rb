require "net/http"

module ServiceAgent
  class Request
    attr_reader :url, :response_code

    def initialize(url)
      @url = normalized_url(url)
    end

    def perform
      @response_code = Net::HTTP.get_response(url).code rescue "Connection refused"
      self
    end

    private
    def normalized_url(url)
      url = "http://#{url}" unless url.match(/http(s)?:\/\//)
      URI(url)
    end
  end
end
