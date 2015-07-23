class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :listings
  has_many :favorites
  has_many :favorite_listings, through: :favorites, source: :listing
  has_many :reviews

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def favorited?(listing)
    Favorite.exists?(user_id: self.id, listing_id: listing.id)
  end
end
