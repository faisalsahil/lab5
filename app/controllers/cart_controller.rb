class CartController < ApplicationController
  
  def show
    load_cart_line_items
    render
  end
  
  def create
    product = Product.find(params[:product_id])
    current_order.add(product)
    redirect_to cart_url
  end
  
  def update
    product = current_order.products.find(params[:product_id])
    current_order.set_quantity(product, params[:quantity].to_i)
    if request.xhr?
      load_cart_line_items
      render json: { content: render_to_string(partial: 'cart_table') }
    else
      redirect_to cart_url
    end
  end
  
  def destroy
    product = Product.find(params[:product_id])
    current_order.remove(product)
    redirect_to cart_url
  end
  
  
  private

  def load_cart_line_items
    @cart_line_items = current_order.line_items(:include => :product)
  end

  def cart
  end
  
end
