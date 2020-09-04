require 'rails_helper'

RSpec.describe IflanForbiddenError, type: :error do
	let(:status_code) { 403 }
	let(:error) { 'forbidden' }
	let(:error_message) { "You don't have permission to perform this action" }

	describe '#new' do
		let(:paper_chef_error) { IflanForbiddenError.new }
		include_examples 'creates error correctly'
	end
end