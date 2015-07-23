class ListingsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @search_string = params[:search_string]
    if params[:slider]
      # refine search
      @price_range = params[:slider].split(",").map { |endpoint| endpoint.to_i }
      @search_results = Listing.search(@search_string).select { |listing|
        listing.price && listing.price.between?(@price_range[0], @price_range[1]) }
      else
        @search_results = Listing.search(@search_string)
      end
    end

    def create
      listing = current_user.listings.new(listing_params)
      if listing.save
        flash[:notice] = "You've successfully created a listing!"
        redirect_to listing_path(listing)
      else
        flash[:alert] = "You're doing it wrong."
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
      redirect_to listing_path(@listing)
    end

    def destroy
      @listing = Listing.find(params[:id])
      @listing.destroy
      redirect_to listings_path
    end

    private
    def listing_params
      params.require(:listing).permit(:name, :location, :image, :description,
      :price, :guest_number, :toilet, :shower, :outlet, :pets)
    end
  end
