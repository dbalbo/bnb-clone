class Listing < ActiveRecord::Base
  belongs_to :user
  validates :name, :presence => true
  validates :location, :presence => true
  has_many :reviews
  has_many :favorites
  has_many :fans, through: :favorites, source: :user

  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def rating
    reviews.average(:rating).to_i
  end

  def self.search(search_string)
    location_results = self.basic_search(location: search_string)
  end

  def self.most_popular(number)
    self.all.sort_by { |listing| -listing.fans.count }[0...number]
  end
end
