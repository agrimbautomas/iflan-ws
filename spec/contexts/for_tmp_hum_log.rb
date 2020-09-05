RSpec.shared_context 'tmp_hum_log information' do
	let(:temperature) { 22.4 }
	let(:humidity) { 68.2 }
	let(:tmp_hum_log_information) { {temperature: temperature, humidity: humidity} }
end