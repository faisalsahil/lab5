require 'test_helper'

class Superadmin::Impersonation < ActionDispatch::IntegrationTest

  fixtures :users

  def test_users_field_last_sign_in_did_not_change_during_impersonation
    admin = users(:admin)
    login admin

    nancy = users(:nancy)
    expected = nancy.last_sign_in_at
    get impersonate_active_admin_user_path(nancy)

    nancy.reload
    assert_equal expected, nancy.last_sign_in_at
  end

  private

  def login(user)
    assert user.valid_password?('welcome')
    post(user_session_path, user: { email: user.email, password: 'welcome'})
  end
end
