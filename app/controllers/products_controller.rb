class ProductsController < ApplicationController

  respond_to :html

  before_filter :ensure_user_is_admin!, except: [:index, :show, :search]

  def index
    products_scope = build_products_scope
    @products = products_scope.order(:name).page(params[:page]).per(12)

    respond_with @products
  end

  def show
    @product = Product.includes(:reviews).find(params[:id])
    @reviews = @product.reviews
    @review = Review.new(product_id: @product.id)
    respond_with @product
  end

  def new
    @product = Product.new
  end

  def create
    @product  = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Product was successfully created.'
    end
    respond_with @product
  end

  def edit
    @product = Product.find(params[:id])

    respond_with @product
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product '#{@product.name}' was successfully updated."
    end
    respond_with @product
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "Product '#{@product.name}' was successfully removed."
    end
    respond_with @product
  end

  def search
    products_scope = build_products_scope
    @products = products_scope.order(:name).page(params[:page]).per(12)

    respond_with @products
  end

  private

  def build_products_scope
    products_scope = if params[:category_id].present?
                       @category = Category.find(params[:category_id])
                       @category.products
                     else
                       Product
                     end

    if params[:q].present?
      products_scope = products_scope.seach_by(params[:q])
    end

    products_scope
  end

  def product_params
    params.require(:product).permit(:name, :category_id, :description, :price, :picture)
  end

end
