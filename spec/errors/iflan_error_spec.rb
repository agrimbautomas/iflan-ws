require 'rails_helper'

RSpec.describe IflanError, type: :error do
	let(:error) { 'an error' }
	let(:error_message) { 'an error message' }

	describe '#create' do
		context 'without status code' do
			let(:status_code) { 400 }
			let(:paper_chef_error) { IflanError.new error, error_message }
			include_examples 'creates error correctly'
		end

		context 'with status code' do
			let(:status_code) { 401 }
			let(:paper_chef_error) { IflanError.new error, error_message, status_code }
			include_examples 'creates error correctly'
		end
	end
end