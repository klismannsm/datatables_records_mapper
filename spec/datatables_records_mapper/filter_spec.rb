require 'spec_helper'

describe DatatablesRecordsMapper::Filter do
  context 'record_list' do
    let(:model) do
      double(:model, search: [], paginate: [], count: 0)
    end
    let(:records) { [1, 2, 3] }
    let(:params) do
      {
        options: {},
        length: 10,
        offset: 0,
        search: { value: 'argument' }
      }
    end
    let(:options) do
      {
        records: records,
      }
    end

    subject { described_class.new(model, params) }

    it 'calls the search method of the model to look for records' do
      expect(model).to receive(:search).with('argument', {})
      subject.record_list
    end

    it 'calls the paginate method of the model' do
      expect(model).to receive(:paginate).with([], 10, nil)
      subject.record_list
    end

    it 'calls the search method with a preexisting records set if it is informed in the parameters' do
      filter = described_class.new(model, params, options)

      expect(model).to receive(:search).with([1, 2, 3], 'argument', {})
      filter.record_list
    end
  end
end
