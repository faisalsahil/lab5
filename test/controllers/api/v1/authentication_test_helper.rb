module Api::V1::AuthenticationTestHelper

  def auth_params(user)
    { email: user.email, format: :json }
  end

  def set_auth_headers!(user)
    request.headers['X-Auth-Token'] = user.authentication_token
  end

end
