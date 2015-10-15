require "sms_service"

module ServiceAgent
  module Notification
    class Phone
      attr_reader :url, :message, :service

      include Deliverable

      def initialize(url, phones)
        @url = url

        @message = Message.new(self)
        @service = SmsService.new(phones)
      end

      def succeed(code)
        # no-op
      end
    end
  end
end
