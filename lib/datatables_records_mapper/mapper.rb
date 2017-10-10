module DatatablesRecordsMapper
  class Mapper
    def initialize(model, params, mapper, options = {})
      @model = model
      @params = params
      @mapper = mapper
      @options = options
    end

    def mapped_records
      records['data'] = records['data'].map { |r| @mapper.map(r) }
      records
    end

    private

    def records
      @records ||= DatatablesRecordsMapper::Filter.new(@model, @params, @options).record_list
    end
  end
end
