RSpec.shared_context 'discount information' do
	let!(:discountable) { create :sale_order }
	let(:notes) { 'Some notes' }
	let(:value) { 10.25 }
	let(:discount_type) { 'percentage' }
	let(:discountable_id) { discountable.id }
	let(:discountable_type) { 'Order' }
	let(:discount_information) { 
		{
			notes: notes,
			value: value,
			discount_type: discount_type,
			discountable_id: discountable_id,
			discountable_type: discountable_type
		}
	}
end