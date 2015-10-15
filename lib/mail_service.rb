class MailService
  attr_reader :emails

  def initialize(emails)
    @emails = emails
  end

  def deliver(message)
    emails.each { |email| send_mail(email, message) }
  end

  private

  def send_mail(email, message)
    # no-op
    puts "Sending mail for #{email} with body: #{message}"
  end
end
