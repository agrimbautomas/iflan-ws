RSpec.shared_context 'user information' do
	let(:first_name) { "Homer" }
	let(:last_name) { "Simpson" }
	let(:role) { :manager }
	let(:email) { "example#{User.count}@test.com" }
	let(:receive_low_stock_notifications) { true }
	let(:password) { 'password' }
	let!(:company) { create :company }
	let(:user_information) { 
		{ 
			first_name: first_name,
			last_name: last_name,
			role: role,
			email: email,
			receive_low_stock_notifications: receive_low_stock_notifications,
			password: password
		} 
	}
end