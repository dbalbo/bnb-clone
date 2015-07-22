class FavoritesController < ApplicationController
  def create
    Favorite.create(favorite_params)
    redirect_to :back
  end

  private
  def favorite_params
    params.require(:favorite).permit(:user_id, :listing_id)
  end
end
