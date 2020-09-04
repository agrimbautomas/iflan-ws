RSpec.shared_examples 'creates the user' do
	include_examples 'user has correct attributes'
	it 'creates the user' do
		expect { user }.to change{ User.count }.by(1)
	end
end

RSpec.shared_examples 'user has correct attributes' do
	it 'has correct attributes' do
		expect(user).to have_attributes({
			first_name: first_name,
			last_name: last_name,
			role: role.to_s,
			email: email,
			receive_low_stock_notifications: receive_low_stock_notifications,
			company: company,
			password: password
		})
	end
end