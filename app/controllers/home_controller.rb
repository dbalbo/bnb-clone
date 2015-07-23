class HomeController < ApplicationController
  def index
    #'popular yards' = "air conditiong homes" also "best air conditioning homes takes the place of 'most-popular'"
    @popular_yards = Listing.most_popular(4)
  end
end
