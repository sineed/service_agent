require "mail_service"

module ServiceAgent
  module Notification
    class Email
      attr_reader :url, :message, :service

      include Deliverable

      def initialize(url, emails)
        @url = url

        @message = Message.new(self)
        @service = MailService.new(emails)
      end

      def succeed(code)
        # no-op
      end
    end
  end
end
