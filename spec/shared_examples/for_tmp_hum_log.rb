RSpec.shared_examples 'creates a tmp_hum_log' do
	include_examples 'tmp_hum_log has correct attributes'
	it 'creates the tmp_hum_log' do
		expect { tmp_hum_log }.to change { TmpHumLog.count }.by(1)
	end
end

RSpec.shared_examples 'tmp_hum_log has correct attributes' do
	it 'has correct attributes' do
		expect(tmp_hum_log).to have_attributes(temperature: temperature, humidity: humidity)
	end
end