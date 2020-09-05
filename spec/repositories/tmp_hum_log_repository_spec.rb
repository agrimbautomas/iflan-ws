require "rails_helper"

RSpec.describe TmpHumLogRepository do
	let(:repository) { TmpHumLogRepository.new }

	describe '#create' do
		include_context 'tmp_hum_log information'
		let(:query) { repository.create tmp_hum_log_information }
		let(:tmp_hum_log) { query }

		context 'with valid params' do
			include_examples 'creates a tmp_hum_log'
		end

		context 'without temperature and humidity' do
			let(:temperature) { nil }
			let(:humidity) { nil }
			include_examples 'repository raises RecordInvalid exception'
		end

	end
end