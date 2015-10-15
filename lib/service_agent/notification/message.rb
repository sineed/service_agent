module ServiceAgent
  module Notification
    class Message
      attr_reader :service

      def initialize(service)
        @service = service
      end

      def succeed(code)
        "#{Time.now} [SUCCEED] Service #{service.url} responded with #{code}"
      end

      def failed(code)
        "#{Time.now} [FAILED] Service #{service.url} responded with #{code}"
      end

      def restored(code)
        "#{Time.now} [RESTORED] Service #{service.url} responded with #{code}"
      end

      def disaster
        "#{Time.now} [DISASTER] service #{service.url} is unavailable for a long time. Agent is turned off"
      end
    end
  end
end
