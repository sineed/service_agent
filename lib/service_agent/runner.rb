require "service_agent/util"
require "service_agent/request"
require "service_agent/notification_services"
require "service_agent/notification"

module ServiceAgent
  class Runner
    attr_reader :url, :emails, :phones, :notification_services, :request, :failed
    attr_accessor :ping_frequency

    RESPONSE_STATUS = "200"

    def initialize(url, options={})
      @url = url
      @emails = options.fetch("emails", [])
      @phones = options.fetch("phones", [])

      @request = Request.new(url)
      @failed = false

      register_notification_services
    end

    def ping
      @ping_frequency = ping_frequencies[0]

      while true do
        single_ping
      end
    end

    def single_ping
      if ping_frequency.nil?
        notification_services.disaster
        exit
      end

      index = ping_frequencies.index(ping_frequency)
      sleep calculate_delay(index)

      response_code = get_response_code
      if response_code == RESPONSE_STATUS
        unless failed
          notification_services.succeed(response_code)
        else
          @failed = false
          @ping_frequency = ping_frequencies[0]
          notification_services.restored(response_code)
        end
      else
        @failed = true
        @ping_frequency = ping_frequencies[index + 1]
        notification_services.failed(response_code)
      end
    end

    def ping_frequencies
      Util.minutes(3, 10, 50, 100, 500)
      # For testing purposes
      # Util.minutes(0.1, 0.2, 0.3, 0.4, 0.5)
    end

    private

    def register_notification_services
      @notification_services = NotificationServices.new([])

      notification_services.register(Notification::Stdout.new(url))
      notification_services.register(Notification::Email.new(url, emails)) if emails.any?
      notification_services.register(Notification::Phone.new(url, phones)) if phones.any?
    end

    def get_response_code
      request.perform.response_code
    end

    def calculate_delay(index)
      prev_frequency = if index == 0
        0
      else
        ping_frequencies[index - 1]
      end

      ping_frequency - prev_frequency
    end
  end
end
