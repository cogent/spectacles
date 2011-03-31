require "pathname"
require "rspec"
require "spectacles"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Pathname(__FILE__).parent + "support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

  config.include Spectacles::RSpec
  config.include Fixtures

end
