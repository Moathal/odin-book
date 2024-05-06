namespace :db do
  desc 'Checks if the database exists'
  task :exists do
    config = ActiveRecord::Base.configurations[Rails.env]
    begin
      ActiveRecord::Base.establish_connection(config).connection
      puts 'Database exists'
    rescue
      exit 1
    end
  end
end