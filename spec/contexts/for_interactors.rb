RSpec.shared_context 'ingredients' do
	let!(:product1) { create :raw_material }
	let(:product1_id) { product1.id }
	let!(:product2) { create :raw_material }
	let(:product2_id) { product2.id }
	let(:size) { 1 }
	let(:ingredients) {
		[
			{
				product_id: product1_id,
				size: size
			},
			{
				product_id: product2_id,
				size: size
			}
		] 
	}
end

RSpec.shared_context 'discount params' do
	let!(:sale_order) { create :sale_order, :with_items }
	let(:id) { sale_order.id }
	let(:notes) { 'Some notes' }
	let(:value) { 10.25 }
	let(:discount_type) { 'amount' }
	let(:discountable_id) { id }
	let(:discountable_type) { 'Order' }
	let(:discount_params) { 
		{
			discount: {
				notes: notes,
				value: value,
				discount_type: discount_type
			},
			id: id
		}
	}
end