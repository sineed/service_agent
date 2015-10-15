require "spec_helper"
require "service_agent/runner"

RSpec.describe ServiceAgent::Runner do
  subject { described_class.new("test_url") }

  let(:bad_request) { double(perform: double(response_code: "404")) }
  let(:good_request) { double(perform: double(response_code: "200")) }

  describe "#single_ping" do
    it "pings according to specified frequencies" do
      allow(subject).to receive(:ping_frequencies) { [1, 2, 3] }
      subject.ping_frequency = subject.ping_frequencies[0]

      # Start with an available service
      allow(subject).to receive(:request) { good_request }

      expect(subject.notification_services).to receive(:succeed)
      subject.single_ping

      expect(subject.notification_services).to receive(:succeed)
      subject.single_ping


      # Something was happened with service
      allow(subject).to receive(:request) { bad_request }

      expect(subject.notification_services).to receive(:failed)
      subject.single_ping

      expect(subject.notification_services).to receive(:failed)
      subject.single_ping


      # Oh, it is available again
      allow(subject).to receive(:request) { good_request }

      expect(subject.notification_services).to receive(:restored)
      subject.single_ping

      expect(subject.notification_services).to receive(:succeed)
      subject.single_ping


      # ... but not so long
      allow(subject).to receive(:request) { bad_request }

      expect(subject.notification_services).to receive(:failed)
      subject.single_ping

      expect(subject.notification_services).to receive(:failed)
      subject.single_ping

      expect(subject.notification_services).to receive(:failed)
      subject.single_ping


      # ... it is really dead
      expect(subject.notification_services).to receive(:disaster)
      expect { subject.single_ping }.to raise_error(SystemExit)
    end
  end
end
