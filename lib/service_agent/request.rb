module ServiceAgent
  class Request
    attr_reader :url, :response_code

    def initialize(url)
      @url = normalized_url(url)
    end

    def perform
      @response_code = begin
        Net::HTTP.start(url.host, url.port) do |http|
          head = http.head(url.request_uri)
          head.code
        end
      rescue
         "Connection refused"
      end

      self
    end

    private
    def normalized_url(url)
      url = "http://#{url}" unless url.start_with?("http://")
      URI(url)
    end
  end
end
