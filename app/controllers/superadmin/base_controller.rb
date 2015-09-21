class Superadmin::BaseController < ApplicationController

  before_filter :authenticate_superadmin_user!

  layout 'superadmin'
  
end
