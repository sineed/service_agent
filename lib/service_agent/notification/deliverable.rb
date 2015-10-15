module ServiceAgent
  module Notification
    module Deliverable
      def succeed(code)
        service.deliver message.succeed(code)
      end

      def failed(code)
        service.deliver message.failed(code)
      end

      def restored(code)
        service.deliver message.restored(code)
      end

      def disaster
        service.deliver message.disaster
      end
    end
  end
end
