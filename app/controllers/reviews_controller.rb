class ReviewsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @listing = Listing.find(params[:listing_id])
    @review = Review.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @review = Review.new(review_params)
    @listing.reviews << @review
    current_user.reviews << @review
    if @review.save
      flash[:notice] = 'You have created a review.'
      redirect_to listing_path(@listing)
    else
      flash[:alert] = 'There was an error.'
      redirect_to :back
    end
  end

  def edit
  @listing = Listing.find(params[:listing_id])
  @review = Review.find(params[:id])
end

  def update
    @listing = Listing.find(params[:listing_id])
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to listing_path(@listing)
  end

  def destroy
    @listing = Listing.find(params[:listing_id])
    @review = Review.find(params[:id])
    @review.delete
    redirect_to listing_path(@listing)
  end

  private
  def review_params
    params.require(:review).permit(:text, :rating)
  end
end
