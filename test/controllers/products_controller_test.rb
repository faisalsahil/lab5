require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  def test_index_renders_message
    admin = users(:admin)
    sign_in admin
    get :index
    assert_response :success
  end

end
