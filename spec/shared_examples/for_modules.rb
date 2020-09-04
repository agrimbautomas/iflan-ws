RSpec.shared_examples 'implements error raiser module' do
	it { is_expected.to respond_to :error }
	it { is_expected.to respond_to :invalid }
end