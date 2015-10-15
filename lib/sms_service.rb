class SmsService
  attr_reader :phones

  def initialize(phones)
    @phones = phones
  end

  def deliver(message)
    phones.each { |phone| send_sms(phone, message) }
  end

  private

  def send_sms(phone, message)
    # no-op
    puts "Sending sms for #{phone} with body: #{message}"
  end
end
