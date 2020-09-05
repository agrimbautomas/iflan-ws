require "rails_helper"

RSpec.describe TmpHumLogRepository do
	let(:repository) { TmpHumLogRepository.new }

	describe '#create' do
		include_context 'tmpHumLog information'
		let(:query) { repository.create tmpHumLog_information }
		let(:tmpHumLog) { query }

		context 'with valid params' do
			include_examples 'creates the tmpHumLog'
		end

		context 'without name' do
			let(:name) { nil }
			include_examples 'repository raises RecordInvalid exception'
		end

		context 'when the name was already in use' do
			let!(:another_tmpHumLog) { create :tmpHumLog }
			let(:name) { another_tmpHumLog.name.capitalize }
			include_examples 'repository raises RecordInvalid exception'
		end
	end

	describe '#find' do
		let(:subject) { :tmpHumLog }
		include_examples 'finds the subject'
	end

	describe '#search_tmpHumLogs' do
		let(:name_to_search) { 'FOO' }
		let(:query) { repository.search_tmpHumLogs name: name_to_search }

		context 'without tmpHumLogs' do
			include_examples 'repository returns an empty list'
		end

		context 'when tmpHumLogs matching the name to search' do
			let!(:tmpHumLog) { create :tmpHumLog, name: 'FOO aaa' }
			let!(:tmpHumLog2) { create :tmpHumLog, name: 'FOO bbb' }
			let(:expected_subjects) { [tmpHumLog2, tmpHumLog] }
			include_examples 'repository returns the correct list'
		end

		context 'when the name is lowercased' do
			let!(:tmpHumLog) { create :tmpHumLog, name: 'foo aaa' }
			let(:expected_subjects) { [tmpHumLog] }
			include_examples 'repository returns the correct list'
		end

		context 'when the name to search is not at the beginning' do
			let!(:tmpHumLog) { create :tmpHumLog, name: 'aaaFOO' }
			include_examples 'repository returns an empty list'
		end

		context 'without name to search' do
			let(:name_to_search) { nil }
			include_examples 'repository returns an empty list'
		end
	end
end