class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id

    if request.xhr?
      if @review.save
          render json: {
            # rendered review
            review: render_to_string(partial: 'review', object: @review),
            # new review form
            form: render_to_string(partial: 'form', locals: { review: Review.new(product_id: @review.product_id) })
          }
      else
        render json: {
            # review form with errors
            form: render_to_string(partial: 'form', locals: { review: @review })
        }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:headline, :content, :attachment, :product_id)
  end

end
