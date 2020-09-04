RSpec.shared_examples 'raises exception' do |exception|
	it { expect { exception_raiser }.to raise_exception exception }
end

RSpec.shared_examples 'creates error correctly' do
	it 'returns correct attributes' do
		expect(paper_chef_error).to have_attributes(
			error: error,
			error_message: error_message,
			status_code: status_code
		)
	end
end