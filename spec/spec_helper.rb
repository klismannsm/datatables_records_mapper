#$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
#require 'datatables_records_mapper'

require 'bundler/setup'
Bundler.setup

require 'datatables_records_mapper'
require 'shoulda/matchers'

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
end
