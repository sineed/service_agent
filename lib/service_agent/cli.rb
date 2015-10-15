require "service_agent/runner"

module ServiceAgent
  class CLI < Thor
    namespace :agent

    desc "monitor URL", "monitors specified service for availability"
    method_option :emails, type: :array, aliases: "-e", desc: "Sets a list of emails for notification"
    method_option :phones, type: :array, aliases: "-p", desc: "Sets a list of phones for notification"

    def monitor(url)
      Runner.new(url, options).ping
    end
  end
end
