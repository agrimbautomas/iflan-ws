RSpec.shared_examples 'service raises RuntimeError exception' do
	include_examples 'service raises exception', RuntimeError
end

RSpec.shared_examples 'service raises exception' do |exception|
	it { expect { service_execute }.to raise_exception exception }
end