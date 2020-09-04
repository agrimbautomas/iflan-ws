require 'rails_helper'

RSpec.shared_context 'create tmp_hum_log' do
	before { post :create, params: params }
end

RSpec.shared_context 'search for a tmp_hum_log' do
	before { get :search, params: search_params }
end

RSpec.shared_examples "expect tmp_hum_log correct response" do 
	include_examples "expect successful response"
	it { 
		expect(response.body).to eq({
			response: {
				id: tmp_hum_log.id,
				name: tmp_hum_log.name
			}
		}.to_json) 
	}
end

RSpec.describe Api::V1::TmpHumLogsController, type: :controller do
	let(:serialization_options) { {} }

	describe "GET search" do
		let(:name) { 'Tmp_hum_log' }
		let(:search_params) { { tmp_hum_log: { name: name } } }

		context "without token" do
			include_context 'search for a tmp_hum_log'
			include_examples "expect unauthorized response"
		end

		context 'with token' do
			include_context "with token"

			context "with correct params" do
				let(:response_collection) { [] }

				context 'without tmp_hum_logs' do
					include_context 'search for a tmp_hum_log'
					include_examples "expect correct collection response"
				end

				context 'with two matching tmp_hum_logs' do
					let!(:tmp_hum_log) { create :tmp_hum_log, name: 'Tmp_hum_log1' }
					let!(:tmp_hum_log2) { create :tmp_hum_log, name: 'Tmp_hum_log2' }
					let(:response_collection) { [tmp_hum_log2, tmp_hum_log] }
					include_context 'search for a tmp_hum_log'

					include_examples "expect correct collection response"
				end
	
				context 'without name' do
					let(:name) { '' }
					let(:error_message) { 'The filter provided must not be nil' }
					let(:error) { 'invalid_filter' }
					include_context 'search for a tmp_hum_log'
	
					include_examples "expect bad request response"
					include_examples "expect correct error response"
				end
			end
		end
	end

	describe 'POST create' do
		include_context 'tmp_hum_log information'
		let(:params) { { tmp_hum_log: tmp_hum_log_information } }

		context "without token" do
			include_context 'create tmp_hum_log'
			include_examples "expect unauthorized response"
		end

		context 'with token' do
			include_context 'with token'

			let(:tmp_hum_log) { Tmp_hum_log.last }

			context 'with valid params' do
				include_context 'create tmp_hum_log'

				include_examples "expect tmp_hum_log correct response"
				include_examples 'tmp_hum_log has correct attributes'
			end

			context 'without name' do
				let(:name) { nil }
				let(:error) { 'invalid_record' }
				let(:error_message) { {"name":["can't be blank"]} }
				include_context 'create tmp_hum_log'

				include_examples "expect unprocessable entity response"
				include_examples "expect correct error response"
			end

			context 'when the name was already used' do
				let!(:another_tmp_hum_log) { create :tmp_hum_log }
				let(:name) { another_tmp_hum_log.name.capitalize }
				let(:error) { 'invalid_record' }
				let(:error_message) { {"name":["has already been taken"]} }
				include_context 'create tmp_hum_log'

				include_examples "expect unprocessable entity response"
				include_examples "expect correct error response"
			end
		end
	end
end