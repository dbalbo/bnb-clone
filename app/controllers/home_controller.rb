class HomeController < ApplicationCOntroller
  def index
    #'popular yards' = "air conditiong homes" also "best air conditioning homes takes the place of 'most-popular'"
    @air_conditioning_homes = Listing.best_air_conditioning(4)
  end
ends
