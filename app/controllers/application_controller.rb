class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_order

  before_action :load_categories
  before_action :set_device_type
  before_action :check_if_request_is_from_an_app

  def authenticate_superadmin_user!
    authenticate_user!

    unless current_user.super_admin?
      redirect_to root_path, alert: "Unauthorized Access!"
    end
  end

  def current_order
    @current_order ||= begin
      Order.find_by_id(session[:order_id]) || Order.create!.tap { |order| session[:order_id] = order.id }
    end
  end

  def load_categories
    @categories = Category.order('name')
  end

  def set_device_type
    request.variant = :phone if browser.mobile?
  end

  def check_if_request_is_from_an_app
    response.headers['NumberOfItemsInCart'] = current_order.line_items.count.to_s
    if request.headers["X-Inapp-Request"].present?
      session[:in_app_request] ||= true
      response.headers['NumberOfItemsInCart'] = current_order.line_items.count.to_s
    end
  end

end
