RSpec.shared_examples 'creates the activity log' do
	it 'creates the activity log' do
		expect { activity_log }.to change{ ActivityLog.count }.by(1)
	end
end

RSpec.shared_examples 'activity log has correct attributes' do
	it 'has correct attributes' do
		expect(activity_log).to have_attributes(
			user: user, log_type: log_type, description: description, barcode: barcode
		)
	end
end

RSpec.shared_examples 'create barcode activity log has correct attributes' do
	let(:description) { "Create barcode #{barcode} with quantity #{quantity}" }
	let(:log_type) { 'create_barcode' }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'delete barcode activity log has correct attributes' do
	let(:description) { "Delete barcode #{barcode} with quantity #{quantity.to_f}" }
	let(:log_type) { 'delete_barcode' }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'fails updating sales report activity log has correct attributes' do
	let(:description) { "Sales Order # #{order.id} could not be updated" }
	let(:log_type) { "fails_updating_sales_report" }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'update barcode quantity activity log has correct attributes' do
	let(:description) { "#{action} barcode #{barcode} quantity by #{difference}" }
	let(:log_type) { 'update_barcode_quantity' }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'location update activity log has correct attributes' do
	let(:description) { "Move #{quantity.to_f} units of barcode #{barcode} from #{old_location} to #{new_location}" }
	let(:log_type) { 'location_update' }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'return barcode activity log has correct attributes' do
	let(:description) { "Return #{quantity.to_f} units of barcode #{barcode} from #{order_class_name} # #{order_id} to location #{location_name}" }
	let(:log_type) { 'return_barcode' }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'work order activity log has correct attributes' do
	let(:description) { "#{action} work order # #{work_order_id} with barcode #{barcode}" }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'create purchase order activity log has correct attributes' do
	let(:order_klass_name) { 'Purchase Order'}
	let(:log_type) { 'create_purchase_order' }
	include_examples 'create order activity log has correct attributes'
end

RSpec.shared_examples 'create sale order activity log has correct attributes' do
	let(:order_klass_name) { 'Sale Order'}
	let(:log_type) { 'create_sale_order' }
	include_examples 'create order activity log has correct attributes'
end

RSpec.shared_examples 'create work order activity log has correct attributes' do
	let(:order_klass_name) { 'Work Order'}
	let(:log_type) { 'create_work_order' }
	include_examples 'create order activity log has correct attributes'
end

RSpec.shared_examples 'create order activity log has correct attributes' do
	let(:description) { "Create #{order_klass_name} # #{order.id}" }
	let(:barcode) { order.barcode.barcode }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'resync xero transaction activity log has correct attributes' do
	let(:description) { "Resync #{xero_transaction_type_name} of #{xero_transactionable_klass_name} # #{xero_transactionable.id}" }
	let(:barcode) { xero_transactionable.barcode.barcode }
	let(:log_type) { 'resync_xero' }
	include_examples 'activity log has correct attributes'
end

RSpec.shared_examples 'update purchase order status activity log has correct attributes' do
	let(:order_klass_name) { 'Purchase Order'}
	let(:log_type) { 'update_purchase_order' }
	include_examples 'update order status activity log has correct attributes'
end

RSpec.shared_examples 'update sale order status activity log has correct attributes' do
	let(:order_klass_name) { 'Sale Order'}
	let(:log_type) { 'update_sale_order' }
	include_examples 'update order status activity log has correct attributes'
end

RSpec.shared_examples 'update work order status activity log has correct attributes' do
	let(:order_klass_name) { 'Work Order'}
	let(:log_type) { 'update_work_order' }
	include_examples 'update order status activity log has correct attributes'
end

RSpec.shared_examples 'update order status activity log has correct attributes' do
	let(:description) { "Update #{order_klass_name} # #{order.id} status from #{old_status} to #{new_status}" }
	let(:barcode) { order.barcode.barcode }
	include_examples 'activity log has correct attributes'
end