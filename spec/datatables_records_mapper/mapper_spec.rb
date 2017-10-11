require 'spec_helper'

describe DatatablesRecordsMapper::Mapper do
  let(:model) do
    double(:model, search: [1, 2, 3], paginate: [1, 2, 3], count: 0)
  end
  let(:params) do
    {
      options: {},
      length: 10,
      offset: 0,
      search: { value: 'argument' }
    }
  end
  let(:mapper) do
    double(:mapper, map: [2, 4, 6])
  end

  subject { described_class.new(model, params, mapper) }

  it 'maps the found records' do
    expect(mapper).to receive(:map).exactly(3).times
    subject.mapped_records
  end
end
