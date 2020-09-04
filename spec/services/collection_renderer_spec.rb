require "rails_helper"

RSpec.shared_examples 'renders collection correctly' do
	it 'renders the collection' do
		expect(render).to eq serialization
	end
end

RSpec.describe CollectionRenderer do
	let!(:sale_order1) { create :sale_order }
	let!(:sale_order2) { create :sale_order }
	let(:collection) { [sale_order1, sale_order2] }
	let(:options) { {} }
	let(:render) { CollectionRenderer.new(collection, options).render }
	let(:service_execute) { render }

	describe '#render' do
		context 'with valid params' do
			let(:serialization) { { response: serialize(collection) } }

			context 'when the options are nil' do
				let(:options) { nil }
				include_examples 'renders collection correctly'
			end
	
			context 'when the options are empty' do
				include_examples 'renders collection correctly'
			end

			context 'when the options have an include' do
				let(:options) { { include: [] } }
				let(:serialization) { { response: serialize_lean(collection) } }
				include_examples 'renders collection correctly'
			end

			context 'when the collection is empty' do
				let(:collection) { [] }
				include_examples 'renders collection correctly'
			end

			context 'when the collection is paginable' do
				let(:collection) { SaleOrder.all.page(1) }
				let(:options) { { paginated: true } }
				let(:serialization) {
					{ 
						response: serialize(collection),
						pagination: {
							current: collection.current_page,
							pages: collection.total_pages,
							first_page: collection.first_page?,
							last_page: collection.last_page?
						}
					} 
				}
				include_examples 'renders collection correctly'
			end
		end

		context 'when the collection is nil' do
			let(:collection) { nil }
			include_examples 'service raises RuntimeError exception'
		end

		context 'when the object to render is not a collection' do
			let(:collection) { sale_order1 }
			include_examples 'service raises RuntimeError exception'
		end

		context 'when the collection is not paginable' do
			let(:options) { { paginated: true } }
			include_examples 'service raises RuntimeError exception'
		end
	end
end