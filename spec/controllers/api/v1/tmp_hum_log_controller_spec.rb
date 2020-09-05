require 'rails_helper'

RSpec.shared_context 'create tmp_hum_log' do
	before { post :create, params: params }
end

RSpec.shared_examples "expect tmp_hum_log correct response" do
	include_examples "expect successful response"
	it {
		expect(response.body).to eq({
				response: {
						temperature: tmp_hum_log.temperature,
						humidity: tmp_hum_log.humidity,
						created_at: tmp_hum_log.created_at,
				}
		}.to_json)
	}
end

RSpec.describe Api::V1::TmpHumLogsController, type: :controller do
	let(:serialization_options) { {} }

	describe 'POST create' do
		include_context 'tmp_hum_log information'
		let(:params) { {tmp_hum_log: tmp_hum_log_information} }
		#
		# context "without token" do
		# 	include_context 'create tmp_hum_log'
		# 	include_examples "expect unauthorized response"
		# end
		#
		# context 'with token' do
		# 	include_context 'with token'

		let(:tmp_hum_log) { TmpHumLog.last }

		context 'with valid params' do
			include_context 'create tmp_hum_log'

			include_examples "expect tmp_hum_log correct response"
			include_examples 'tmp_hum_log has correct attributes'
		end
		#
		# context 'without name' do
		# 	let(:name) { nil }
		# 	let(:error) { 'invalid_record' }
		# 	let(:error_message) { {"name": ["can't be blank"]} }
		# 	include_context 'create tmp_hum_log'
		#
		# 	include_examples "expect unprocessable entity response"
		# 	include_examples "expect correct error response"
		# end
		#
		# context 'when the name was already used' do
		# 	let!(:another_tmp_hum_log) { create :tmp_hum_log }
		# 	let(:name) { another_tmp_hum_log.name.capitalize }
		# 	let(:error) { 'invalid_record' }
		# 	let(:error_message) { {"name": ["has already been taken"]} }
		# 	include_context 'create tmp_hum_log'
		#
		# 	include_examples "expect unprocessable entity response"
		# 	include_examples "expect correct error response"
		# end
		# end
	end
end