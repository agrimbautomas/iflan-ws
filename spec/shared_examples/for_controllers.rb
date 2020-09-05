RSpec.shared_examples "expect json content type" do |status|
	it { expect(response.content_type).to eq "application/json; charset=utf-8" }
	it { expect(response.status).to eq status }
end

RSpec.shared_examples "expect successful response" do
	include_examples "expect json content type", 200
end

RSpec.shared_examples "expect correct empty response" do
	it { expect(response.content_type).to eq "text/html" }
	it { expect(response.status).to eq status }
	it { expect(response.body).to be_empty }
end

RSpec.shared_examples "expect correct successful empty response" do 
	let(:status) { 200 }
	include_examples "expect correct empty response"
end

RSpec.shared_examples "expect correct object response" do
	let(:response_serialization) { 
		ActiveModelSerializers::SerializableResource.new object_rendered, serialization_options 
	}

	include_examples "expect successful response"
	it do
		actual_body = JSON.parse response.body
		expected_body = JSON.parse( { response: response_serialization }.to_json )
		expect( actual_body ).to eq expected_body
	end
end

RSpec.shared_examples "expect correct collection response" do
	let(:object_rendered) { response_collection }
	include_examples "expect correct object response"
end

RSpec.shared_examples "expect correct paginated collection response" do
	let(:pagination_serialization) { 
		{
			current: current_page,
			pages: total_pages,
			first_page: first_page?,
			last_page: last_page?
		}
	}
	let(:collection_serialization) { 
		ActiveModelSerializers::SerializableResource.new response_collection, serialization_options 
	}
	include_examples "expect successful response"
	it { expect(response.body).to eq({ response: collection_serialization, pagination: pagination_serialization }.to_json )}
end

RSpec.shared_examples 'expect successful message response' do
	include_examples "expect successful response"
	it do
		actual_body = JSON.parse response.body
		expected_body = JSON.parse( { response: { message: message } }.to_json )
		expect( actual_body ).to eq expected_body
	end
end

RSpec.shared_examples "expect correct error response" do
	it { 
		expect(response.body).to eq({
			response: {
				error: error,
				error_message: error_message
			}
		}.to_json )
	}
end

RSpec.shared_examples "expect bad request response" do
	include_examples "expect json content type", 400
end

RSpec.shared_examples "expect unauthorized response" do
	it { expect(response.status).to eq 401 }
end

RSpec.shared_examples "expect forbidden response" do
	it { expect(response.status).to eq 403 }
	let(:error) { 'forbidden' }
	let(:error_message) { "You don't have permission to perform this action" }
	include_examples "expect correct error response"
end

RSpec.shared_examples "expect not found response" do
	include_examples "expect json content type", 404
end

RSpec.shared_examples "record not found response is correct" do
	include_examples "expect not found response"
	it { expect(JSON.parse(response.body)['response']['error']).to eq "record_not_found" }
end

RSpec.shared_examples "expect unprocessable entity response" do
	include_examples "expect json content type", 422
end

RSpec.shared_examples "expect discount correct response" do 
	include_examples "expect successful response"
	it { expect(response.body).to eq(
		{
			response: {
				id: discount.id,
				value: discount.value,
				discount_type: discount.discount_type,
				notes: discount.notes
			}
		}.to_json
	)}
end

RSpec.shared_examples 'get index paginated' do
	include_context 'pagination params'
	let(:response_collection) { [] }

	context "without token" do
		include_context 'get models paginated'
		include_examples "expect unauthorized response"
	end

	context 'with token' do
		include_context 'with token'

		context 'without models' do
			let(:total_pages) { 0 }
			let(:last_page?) { false }
			include_context 'get models paginated'
			include_examples "expect correct paginated collection response"
		end

		context 'with two models' do
			let!(:subject1) { create subject }
			let!(:subject2) { create subject }
			let(:total_pages) { 1 }
			let(:last_page?) { true }
			let(:response_collection) { [subject2, subject1] }
			include_context 'get models paginated'
			include_examples "expect correct paginated collection response"

			context 'and per page param is 1' do
				let(:per_page) { 1 }
				let(:total_pages) { 2 }
				let(:last_page?) { false }
				let(:response_collection) { [subject2] }
				include_context 'get models paginated'
				include_examples "expect correct paginated collection response"

				context 'and page param is 2' do
					let(:page) { 2 }
					let(:current_page) { 2 }
					let(:first_page?) { false }
					let(:last_page?) { true }
					let(:response_collection) { [subject1] }
					include_context 'get models paginated'
					include_examples "expect correct paginated collection response"
				end
			end
	
			context 'and page param is 2' do
				let(:page) { 2 }
				let(:current_page) { 2 }
				let(:first_page?) { false }
				let(:last_page?) { false }
				let(:response_collection) { [] }
				include_context 'get models paginated'
				include_examples "expect correct paginated collection response"
			end
		end
	end
end

RSpec.shared_examples 'search basic controller' do
	let(:attribute_value) { 'Test' }
	let(:attributes_for_subject) { 
		h = {}
		h[attribute_to_search] = 'Test 1'
		h
	}
	let(:attributes_for_subject2) { 
		h = {}
		h[attribute_to_search] = 'Test 2'
		h
	}

	let(:page) { nil }
	let(:per_page) { nil }

	context "without token" do
		include_context 'search request'
		include_examples "expect unauthorized response"
	end

	context 'with token' do
		include_context "with token"

		context "with correct params" do
			let(:response_collection) { [] }

			context 'without models' do
				include_context 'search request'
				include_examples "expect correct collection response"
			end

			context 'with two matching models' do
				let!(:model) { create model_factory, attributes_for_subject }
				let!(:model2) { create model_factory, attributes_for_subject2 }
				let(:response_collection) { [model2, model] }
				include_context 'search request'

				include_examples "expect correct collection response"
			end

			context 'without attribute value' do
				let(:attribute_value) { '' }
				let(:error_message) { 'The filter provided is not permitted' }
				let(:error) { 'invalid_filter' }
				include_context 'search request'

				include_examples "expect bad request response"
				include_examples "expect correct error response"
			end

			context 'when the attribute to search is not permitted' do
				let(:attribute_to_search) { attribute_not_permitted }
				let(:error_message) { 'The filter provided is not permitted' }
				let(:error) { 'invalid_filter' }
				include_context 'search request'

				include_examples "expect bad request response"
				include_examples "expect correct error response"
			end

			context 'with pagination' do
				let!(:model) { create model_factory, attributes_for_subject }
				let!(:model2) { create model_factory, attributes_for_subject2 }

				context 'without per page param' do
					let!(:page) { 1 }
					let(:response_collection) { [model2, model] }
					include_context 'search request'
		
					include_examples "expect correct collection response"
				end

				context 'without page param' do
					let!(:per_page) { 1 }
					let(:response_collection) { [model2, model] }
					include_context 'search request'
		
					include_examples "expect correct collection response"
				end

				context 'with page and per page params' do
					let(:attributes_for_subject3) { 
						h = {}
						h[attribute_to_search] = 'Test 3'
						h
					}
					let!(:model3) { create model_factory, attributes_for_subject3 }
					let!(:page) { 1 }
					let!(:per_page) { 2 }
					let(:current_page) { 1 }
					let(:total_pages) { 2 }
					let(:first_page?) { true }
					let(:last_page?) { false }
					let(:response_collection) { [model3, model2] }
					include_context 'search request'
		
					include_examples "expect correct paginated collection response"
				end
			end

			context 'without params' do
				let(:search_params) { {} }
				let(:error_message) { 'The filter provided must not be nil' }
				let(:error) { 'invalid_filter' }
				include_context 'search request'

				include_examples "expect bad request response"
				include_examples "expect correct error response"
			end
		end
	end
end

RSpec.shared_examples 'search with nested attributes controller' do
	let(:search_params) { 
		h = {}
		h[search_type] = {}
		h[search_type][attribute_to_search] = attribute_value
		h
	}

	include_examples 'search basic controller'
end

RSpec.shared_examples 'user gets xero transactions' do
	context "without token" do
		include_context 'get xero transactions'
		include_examples "expect unauthorized response"
	end

	context 'with token' do
		include_context 'with token'

		context 'without transactions' do
			let(:response_collection) { [] }
			include_context 'get xero transactions'
			include_examples "expect correct collection response"
		end

		context 'with transactions' do
			let!(:xero_transaction) { create :xero_transaction, :bill_account, xero_transactionable: order }
			let!(:xero_transaction2) { create :xero_transaction, :raw_inventory, xero_transactionable: order }
			let(:response_collection) { [xero_transaction2, xero_transaction] }
			include_context 'get xero transactions'
			include_examples "expect correct collection response"
		end
	end
end

RSpec.shared_examples "expect deprecated endpoint correct response" do 
	include_examples "expect successful response"
	it 'serializes the location correctly' do
		expected = JSON.parse( { response: { message: 'This endpoint has been deprecated' } }.to_json, symbolize_names: true )
		body = JSON.parse( response.body, symbolize_names: true )
		expect(body).to eq(expected) 
	end
end