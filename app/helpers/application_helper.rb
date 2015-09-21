module ApplicationHelper

  def super_admin_signed_in?
    user_signed_in? && current_user.super_admin?
  end

  def nav_link text, path, condition = false, options = {}
    class_name = (current_page?(path) || condition) ? 'active' : ''

    content_tag(:li, class: class_name) do
      options[:title] = text unless options.has_key?(:title)
      link_to text, path, options
    end
  end

  def link_to_with_icon(text, path, options = {})
    icon_class = options.delete(:icon)
    link_to path, options do
      if icon_class.present?
        content_tag(:i, ' ', class: icon_class) + text
      else
        text
      end
    end
  end

  def link_to_cart(options = {})
    cart_link_text = "Cart"
    if cart_items_count > 0
      cart_link_text += " (#{cart_items_count})"
    end
    link_to_with_icon cart_link_text, cart_path, options
  end

  def cart_items_count
    current_order.line_items.count
  end

end
