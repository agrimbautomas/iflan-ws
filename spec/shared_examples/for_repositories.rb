require "rails_helper"

RSpec.shared_examples 'repository returns the correct list' do
	it 'returns the correct list' do
		expect(query == expected_subjects).to be true
	end
end

RSpec.shared_examples 'repository returns an empty list' do
	it 'returns an empty list' do
		expect(query).to be_empty
	end
end

RSpec.shared_examples 'get subjects paginated' do
	let(:expected_subjects) { [] }

	let(:page) { 1 }
	let(:per_page) { 20 }

	context 'without subjects' do
		include_examples 'repository returns an empty list'
	end

	context 'with two subjects' do
		let!(:subject1) { create subject, attributes_for_subject1 }
		let!(:subject2) { create subject, attributes_for_subject2 }
		let(:sorted_subjects) { 
			sorted_subjects = [subject2, subject1].sort_by { |e| e[sorted_by] } 
			sorted_subjects = sorted_subjects.reverse unless sorted_asc
			sorted_subjects
		}
		let(:expected_subjects) { sorted_subjects }
		include_examples 'repository returns the correct list'

		context 'and per page is 1' do
			let(:per_page) { 1 }
			let(:expected_subjects) { [sorted_subjects.first] }
			include_examples 'repository returns the correct list'

			context 'and page is 2' do
				let(:page) { 2 }
				let(:per_page) { 1 }
				let(:expected_subjects) { [sorted_subjects.second] }
				include_examples 'repository returns the correct list'
			end
		end

		context 'and page is 2' do
			let(:page) { 2 }
			include_examples 'repository returns an empty list'
		end
	end

	context 'with 30 subjects' do
		before { 
			30.times do 
				create subject
			end
		}

		context 'without per page param' do
			let(:per_page) { nil }
			it 'returns 25 subjects' do
				expect(query.count).to eq 25
			end
		end

		context 'without page param' do
			let(:expected_subjects) { query.limit 20 }
			let(:page) { nil }
			include_examples 'repository returns the correct list'
		end
	end

	context 'with invalid page' do
		let(:page) { -1 }
		include_examples 'repository returns an empty list'
	end

	context 'with invalid per page' do
		let(:per_page) { -1 }
		include_examples 'repository returns an empty list'
	end
end

RSpec.shared_examples 'builds the discount' do
	include_examples 'discount has correct attributes'
	it 'builds the discount' do
		expect { discount }.to change{ Discount.count }.by(0)
	end
end

RSpec.shared_examples 'creates the discount' do
	include_examples 'discount has correct attributes'
	it 'creates the discount' do
		expect { discount }.to change{ Discount.count }.by(1)
	end
end

RSpec.shared_examples 'discount has correct attributes' do
	it 'has correct attributes' do
		expect(discount).to have_attributes(
			notes: notes,
			value: value,
			discount_type: discount_type,
			discountable_id: discountable_id,
			discountable_type: discountable_type
		)
	end
end

RSpec.shared_examples 'creates the sale order item' do
	include_examples 'sale order item has correct attributes'
	it 'creates the sale order item' do
		expect { sale_order_item }.to change{ SaleOrderItem.count }.by(1)
	end
end

RSpec.shared_examples 'sale order item has correct attributes' do
	it 'has correct attributes' do
		expect(sale_order_item).to have_attributes(
			order: sale_order,
			product: finished_good,
			price_value: price_value,
			price_currency: price_currency,
			quantity: quantity
		)
	end
end

RSpec.shared_examples 'creates the finished good without image' do
	include_examples 'creates the finished good'
	include_examples 'product doesn\'t have image'
end

RSpec.shared_examples 'creates the finished good' do
	include_examples 'product has correct attributes'
	it 'creates the finished good' do
		expect { product }.to change{ FinishedGood.count }.by(1)
	end
end

RSpec.shared_examples 'creates the ingredient' do
	it 'creates the ingredient' do
		expect(@ingredient).to have_attributes(
			finished_good_id: finished_good_id,
			product_id: product_id,
			size: size
		)
	end
	include_examples 'the number of ingredients is correct', 1
end

RSpec.shared_examples 'the number of ingredients is correct' do |number_of_ingredients|
	it 'has the correct number of ingredients' do
		expect(Ingredient.count).to be number_of_ingredients
	end
end

RSpec.shared_examples 'marks the sale order as archived' do
	it 'marks the sale order as archived' do
		expect(@sale_order.deleted_at).to_not be nil
	end
end

RSpec.shared_examples 'marks the purchase order as archived' do
	it 'marks the purchase order as archived' do
		expect(@purchase_order.deleted_at).to_not be nil
	end
end

RSpec.shared_examples 'finds the subject' do
	let(:query) { repository.find id }

	context 'with invalid id' do
		let(:id) { nil }
		include_examples 'repository raises RecordNotFound exception'
	end

	context 'with valid id' do
		let!(:subject_to_find) { create subject }
		let(:id) { subject_to_find.id }
		it 'returns the correct subject' do
			expect(query).to eq subject_to_find
		end
	end
end

RSpec.shared_examples 'destroys the subject' do
	let(:query) { repository.destroy! id }

	context 'with invalid id' do
		let(:id) { nil }
		include_examples 'repository raises RecordNotFound exception'
	end

	context 'with valid id' do
		let!(:model) { create factory }
		let(:id) { model.id }

		it 'deletes the model' do
			expect { query }.to change{ klass.count }.by(-1)
			expect { model.reload }.to raise_error ActiveRecord::RecordNotFound
		end
	end
end

RSpec.shared_examples 'repository archives the model' do
	let(:query) { repository.archive id }

	context 'with invalid id' do
		let(:id) { nil }
		include_examples 'repository raises RecordNotFound exception'
	end

	context 'with valid id' do
		let!(:model) { create factory }
		let(:id) { model.id }
		before { query }

		it 'marks the model as deleted' do
			expect(model.reload.archived?).to be true
		end
	end
end

RSpec.shared_examples 'search' do
	let(:attribute_value) { 'Test' }
	let(:attribute_value_for_subject) { 'Test 1' }
	let(:attributes_for_subject) { 
		h = {}
		h[attribute_to_search] = attribute_value_for_subject
		h
	}
	let(:attributes_for_subject2) { 
		h = {}
		h[attribute_to_search] = 'Test 2'
		h
	}

	context 'without subjects' do
		include_examples 'interactor returns an empty list'
	end

	context 'when subject matching the attribute to search' do
		let!(:model) { create model_factory, attributes_for_subject }
		let!(:model2) { create model_factory, attributes_for_subject2 }
		let(:expected_subjects) { [model, model2] }
		include_examples 'interactor returns the correct list'

		context 'but the subject has been archived' do
			let(:attributes_for_subject3) { 
				h = {}
				h[attribute_to_search] = 'Test 3'
				h
			}
			let!(:model3) { create model_factory, :archived, attributes_for_subject3 }
			include_examples 'interactor returns the correct list'
		end
	end

	context 'when the attribute value is lowercased' do
		let(:attribute_value_for_subject) { 'test 1' }
		let!(:model) { create model_factory, attributes_for_subject }
		let(:expected_subjects) { [model] }
		include_examples 'interactor returns the correct list'
	end

	context 'when the attribute value to search is not at the beginning' do
		let(:attribute_value_for_subject) { '1 Test' }
		let!(:model) { create model_factory, attributes_for_subject }
		include_examples 'interactor returns an empty list'
	end

	context 'without attribute value to search' do
		let(:attribute_value) { nil }
		include_examples 'interactor returns an empty list'
	end
end

RSpec.shared_examples 'repository raises RecordNotFound exception' do
	let(:exception_raiser) { query }
	include_examples 'raises exception', ActiveRecord::RecordNotFound
end

RSpec.shared_examples 'repository raises RecordInvalid exception' do
	let(:exception_raiser) { query }
	include_examples 'raises exception', ActiveRecord::RecordInvalid
end

RSpec.shared_examples 'repository raises StatementInvalid exception' do
	let(:exception_raiser) { query }
	include_examples 'raises exception', ActiveRecord::StatementInvalid
end

RSpec.shared_examples 'repository raises PaperChefError exception' do
	let(:exception_raiser) { query }
	include_examples 'raises exception', PaperChefError
end

RSpec.shared_examples 'repository raises ArgumentError exception' do
	let(:exception_raiser) { query }
	include_examples 'raises exception', ArgumentError
end

RSpec.shared_examples 'repository raises RuntimeError exception' do
	let(:exception_raiser) { query }
	include_examples 'raises exception', RuntimeError
end
