RSpec.shared_examples 'model raises RecordInvalid exception' do
	let(:exception_raiser) { model }
	include_examples 'raises exception', ActiveRecord::RecordInvalid
end

RSpec.shared_examples 'model raises IflanError exception' do
	let(:exception_raiser) { model }
	include_examples 'raises exception', IflanError
end

RSpec.shared_examples 'model raises RuntimeError exception' do
	let(:exception_raiser) { model }
	include_examples 'raises exception', RuntimeError
end

RSpec.shared_examples 'validates uniqueness' do
	context 'when the name is not repeated' do
		let(:subject) { build subject_factory }
		it { expect(subject).to be_valid }
	end

	context 'when the name is repeated' do
		context 'by another type of subject' do
			let!(:another_subject) { create another_subject_factory }
			let(:subject) { build subject_factory, name: another_subject.name }
			it { expect(subject).to_not be_valid }
		end

		context 'by an archived subject' do
			let!(:another_subject) { create subject_factory, :archived }
			let(:subject) { build subject_factory, name: another_subject.name }
			it { expect(subject).to be_valid }
		end

		context 'by an active subject' do
			let!(:another_subject) { create subject_factory }
			let(:subject) { build subject_factory, name: another_subject.name }
			it { expect(subject).to_not be_valid }
		end

		context 'uppercased' do
			let!(:another_subject) { create subject_factory }
			let(:subject) { build subject_factory, name: another_subject.name.upcase }
			it { expect(subject).to_not be_valid }
		end

		context 'with spaces at the beginning and the end' do
			let!(:another_subject) { create subject_factory }
			let(:subject) { build subject_factory, name: " #{another_subject.name} " }
			it { expect(subject).to_not be_valid }
		end
	end
end