require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# In order to send PATCH and DELETE requests, I will need to add a line of code here...
use Rack::MethodOverride

# here is will I will mount other controllers using 'use'
use UsersController
use GoalsController

run ApplicationController
