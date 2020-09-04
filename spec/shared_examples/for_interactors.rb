RSpec.shared_examples 'creates ingredients with correct attributes' do
	it 'creates ingredients with correct attributes' do
		expect(first_ingredient).to have_attributes(
			finished_good: finished_good,
			product: product1,
			size: size
		)
		expect(second_ingredient).to have_attributes(
			finished_good: finished_good,
			product: product2,
			size: size
		)
	end
end

RSpec.shared_examples 'adds a discount to the sale order' do
	it 'adds a discount to the sale order' do
		expect(sale_order.reload.discounts).to match_array [discount]
	end
end

RSpec.shared_examples 'returns the correct subject list' do
	it 'returns the correct subject list' do
		expect(interactor_execute == expected_array).to be true
	end
end

RSpec.shared_examples 'returns an empty subject list' do
	it 'returns an empty list' do
		expect(interactor_execute).to be_empty
	end
end

RSpec.shared_examples 'paginated subjects' do
	let(:page) { 1 }
	let(:per_page) { 20 }
	let(:expected_array) { [] }

	context 'without subjects' do
		include_examples 'returns an empty subject list'
	end

	context 'with two subjects' do
		let!(:subject1) { create subject }
		let!(:subject2) { create subject }
		let(:expected_array) { [subject2, subject1] }
		include_examples 'returns the correct subject list'

		context 'and per page param is 1' do
			let(:per_page) { 1 }
			let(:expected_array) { [subject2] }
			include_examples 'returns the correct subject list'

			context 'and page param is 2' do
				let(:page) { 2 }
				let(:per_page) { 1 }
				let(:expected_array) { [subject1] }
				include_examples 'returns the correct subject list'
			end
		end

		context 'and page param is 2' do
			let(:page) { 2 }
			include_examples 'returns an empty subject list'
		end
	end

	context 'with invalid page' do
		let(:page) { -1 }
		include_examples 'returns an empty subject list'
	end

	context 'with invalid per page' do
		let(:per_page) { -1 }
		include_examples 'returns an empty subject list'
	end
end

RSpec.shared_examples 'archives the model without execute' do
	let!(:model) { create factory }
	let(:model_id) { model.id }

	describe '#self.with' do
		context 'with valid params' do
			before { @model_deleted = interactor_execute }

			it 'marks the model as archived' do
				expect(@model_deleted.deleted_at).to_not be nil
			end
		end

		context 'when the model was already archived' do
			let!(:model) { create factory, :archived }
			include_examples 'interactor raises IflanError exception'
		end

		context 'without model id' do
			let(:model_id) { nil }
			include_examples 'interactor raises RecordNotFound exception'
		end

		context 'with invalid id' do
			let(:model_id) { model.id + 100 }
			include_examples 'interactor raises RecordNotFound exception'
		end
	end
end

RSpec.shared_examples 'archives the model' do
	include_examples 'archives the model without execute'

	describe '#new' do
		context 'without repository' do
			let(:interactor_execute) { 
				interactor_klass.new(model_id: model_id, repository: nil).execute 
			}
			include_examples 'interactor raises RuntimeError exception'
		end
	end
end

RSpec.shared_examples 'search subjects paginated' do
	context 'without per page param' do
		let!(:page) { 1 }
		let(:expected_array) { sorted_subjects }
		include_examples 'returns the correct subject list'
	end

	context 'without page param' do
		let!(:per_page) { 1 }
		let(:expected_array) { sorted_subjects }
		include_examples 'returns the correct subject list'
	end

	context 'with page and per page params' do
		let!(:page) { 1 }
		let!(:per_page) { 2 }
		let(:expected_array) { sorted_subjects.take 2 } 
		include_examples 'returns the correct subject list'
	end
end

RSpec.shared_examples 'interactor returns an empty list' do
	it 'returns an empty list' do
		expect(interactor_execute).to be_empty
	end
end

RSpec.shared_examples 'interactor returns the correct list' do
	it 'returns the correct list' do
		expect(interactor_execute).to match_array expected_subjects
	end
end

RSpec.shared_examples 'returns the correct searched list' do
	it 'returns the correct searched list' do
		expect(interactor_execute == expected_array).to be true
	end
end

RSpec.shared_examples 'interactor raises RecordNotFound exception' do
	include_examples 'interactor raises exception', ActiveRecord::RecordNotFound
end

RSpec.shared_examples 'interactor raises RecordInvalid exception' do
	include_examples 'interactor raises exception', ActiveRecord::RecordInvalid
end

RSpec.shared_examples 'interactor raises IflanError exception' do
	include_examples 'interactor raises exception', IflanError
end

RSpec.shared_examples 'interactor raises RuntimeError exception' do
	include_examples 'interactor raises exception', RuntimeError
end

RSpec.shared_examples 'interactor raises ArgumentError exception' do
	include_examples 'interactor raises exception', ArgumentError
end

RSpec.shared_examples 'interactor raises exception' do |exception|
	it { expect { interactor_execute }.to raise_exception exception }
end