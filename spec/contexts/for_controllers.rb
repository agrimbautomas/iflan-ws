RSpec.shared_context "token" do
	let(:token) { double :acceptable? => true }
end

RSpec.shared_context "with token" do
	let!(:super_admin_user) { @user ||= create :user, :super_admin }
	let(:user) { super_admin_user }
	include_context "token"
	before { allow( controller ).to receive( :doorkeeper_token ) { token } }
	before { allow( controller ).to receive( :current_user ) { super_admin_user } }
end

RSpec.shared_context "with admin token" do
	let!(:admin_user) { @admin_user ||= create :user, :admin }
	let(:user) { admin_user }
	include_context "token"
	before { allow( controller ).to receive( :doorkeeper_token ) { token } }
	before { allow( controller ).to receive( :current_user ) { admin_user } }
end

RSpec.shared_context "with manager token" do
	let!(:manager_user) { @manager_user ||= create :user, :manager }
	let(:user) { manager_user }
	include_context "token"
	before { allow( controller ).to receive( :doorkeeper_token ) { token } }
	before { allow( controller ).to receive( :current_user ) { manager_user } }
end

RSpec.shared_context "with user token" do
	let!(:user_role_user) { @user_role_user ||= create :user, :user }
	let(:user) { user_role_user }
	include_context "token"
	before { allow( controller ).to receive( :doorkeeper_token ) { token } }
	before { allow( controller ).to receive( :current_user ) { user_role_user } }
end

RSpec.shared_context 'get models paginated' do
	before { get :index, params: { page: page, per_page: per_page } }
end

RSpec.shared_context 'search request' do
	before { get :search, params: search_params.merge({page: page, per_page: per_page}) }
end

RSpec.shared_context 'print barcodes' do
	before { get :print_barcodes, params: params }
end

RSpec.shared_context 'get xero transactions' do
	before { get :xero_transactions, params: params }
end

RSpec.shared_context 'pagination params' do
	let(:total_pages) { 1 }
	let(:last_page?) { true }
	let(:page) { 1 }
	let(:per_page) { 20 }
	let(:current_page) { 1 }
	let(:first_page?) { true }
end