require "rails_helper"

RSpec.shared_examples 'renders object correctly' do
	it 'renders the object' do
		expect(render).to eq serialization
	end
end

RSpec.describe ObjectRenderer do
	let!(:object) { create :sale_order }
	let(:options) { {} }
	let(:render) { ObjectRenderer.new(object, options).render }
	let(:service_execute) { render }

	describe '#render' do
		context 'with valid params' do
			let(:serialization) { { response: serialize(object) } }

			context 'when the options are nil' do
				let(:options) { nil }
				include_examples 'renders object correctly'
			end

			context 'when the options are empty' do
				include_examples 'renders object correctly'
			end
		end

		context 'when the object is nil' do
			let(:object) { nil }
			include_examples 'service raises RuntimeError exception'
		end

		context 'when the object to render is a collection' do
			let(:object) { [create(:sale_order)] }
			include_examples 'service raises RuntimeError exception'
		end
	end
end