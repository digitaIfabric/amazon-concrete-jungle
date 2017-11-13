class ReviewsController < ApplicationController
  def create
    # Find product by product id
    product = Product.find(params[:product_id])
    # Check if the user is logged in
    @review = product.reviews.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to product_path(params[:product_id])
    else
      redirect_to [:products]
    end
    # after @review has been initialized, but before calling .save on it:
    # @review.user = current_user
  end

  def destroy
  end

  private
  def review_params
    params.require(:review).permit(:description, :rating)
  end

end