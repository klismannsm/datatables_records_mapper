module DatatablesRecordsMapper
  class Filter
    def initialize(model, params, options = {})
      @model = model
      @params = params
      @options = options
    end

    def record_list
      number_of_filtered_records = records.length
      paginated_records = @model.paginate(records, limit, offset)
      {
        'recordsTotal' => @model.count,
        'recordsFiltered' => number_of_filtered_records,
        'data' => paginated_records
      }
    end

    private

    def records
      @records ||= begin
        return @model.search(search_parameter, param_options) unless @options.has_key? :records
        @model.search(@options[:records], search_parameter, param_options)
      end
    end

    def search_parameter
      @params[:search][:value]
    end

    def param_options
      @param_options ||= @params[:options] || {}
    end

    def limit
      @params[:length]
    end

    def offset
      @params[:start]
    end
  end
end
