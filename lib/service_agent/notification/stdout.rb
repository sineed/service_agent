require "puts_service"

module ServiceAgent
  module Notification
    class Stdout
      attr_reader :url, :message, :service

      include Deliverable

      def initialize(url)
        @url = url

        @message = Message.new(self)
        @service = PutsService.new
      end
    end
  end
end
