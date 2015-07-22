class ListingsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def create
    listing = current_user.listings.new(listing_params)
    if listing.save
      flash[:notice] ='You have created a listing.'
      redirect_to listing_path(listing)
    else
      flash[:alert] = 'There was an error.'
      redirect_to :back
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
    redirect_to listings_path
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
  end
end
