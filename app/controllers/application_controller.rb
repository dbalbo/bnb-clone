class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def has_amenity(amenity)
    if amenity
      "Yes"
    else
      "No"
    end
  end
  helper_method :has_amenity
end
