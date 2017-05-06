require 'reports_kit'

require 'database_cleaner'
require 'pry'
require 'timecop'
require 'support/factory_girl'
require 'support/helpers'

directory = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{directory}/factories/*.rb") { |file| require file }
Dir.glob("#{directory}/support/models/*.rb") { |file| require file }

Time.zone = ActiveSupport::TimeZone.new('UTC')
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'reports_kit_test',
  username: 'postgres',
  encoding: 'unicode'
)
require 'support/schema'

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before(:each) do
    Timecop.freeze(Time.utc(2010))
  end
  config.after(:each) do
    Timecop.return
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include Helpers
end