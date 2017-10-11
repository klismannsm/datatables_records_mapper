The purpose of this gem is to handle the ajax calls made by the [datatables plugin](https://datatables.net).

It parses some of the parameters (not all are yet supported) and returns the required data.

USAGE:
To use this gem you will need to call the mapper class passing as arguments the model, parameters and a mapper. In this
example, it is used a mapper which uses a partial view to render the actions column.

First, let's take a look at a piece of controller code:
```erb
def services_list
  respond_to do |format|
    format.json { render json: services_list_data }
  end
end

private

def services_list_data
  mapper = ModelMappers::ServiceMapper.new(service_actions)
  DatatablesRecordsMapper::Mapper
    .new(Service, params, mapper)
    .mapped_records
end

def service_actions
  @service_actions ||= Proc.new do |service|
    render_to_string(
      'actions',
      locals: { service_id: service.id },
      formats: :html,
      layout: false
    )
  end
end
```

This code is responsible for the endpoint 'GET services/services_list'. It instanciates a mapper for the model Service,
which uses the service_acitons proc to render the actions column.

The mapper code:
```erb
module ModelMappers
  class ServiceMapper
    def initialize(actions_renderer)
      @actions_renderer = actions_renderer
    end

    def map(service)
      {
        id: service.id,
        title: service.title,
        description: service.description,
        actions: @actions_renderer.call(service)
      }
    end
  end
end
```

The only restriction in this class is the method 'map', which is used by the gem to return the data.

The actions partial view:
```erb
a.btn.btn-success.btn-margin-right title=(I18n.t 'links.default.actions.show') href=(service_path(service_id))
  span.fa.fa-search
```

The model code:
```erb
class Service < ActiveRecord::Base
  class << self
    def search(search_parameter, options)
      services = Service.all
      return services unless search_parameter.present?
      search_parameter = "%#{search_parameter.downcase}%"
      services.where('LOWER(title) like ? OR LOWER(description) like ?', search_parameter, search_parameter)
    end

    def paginate(services, limit, offset)
      services.
        order('id desc').
        limit(limit).
        offset(offset)
    end
  end
end
```
