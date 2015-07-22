class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.column(:name, :string)
      t.column(:location, :string)
      t.column(:user_id, :integer)
      t.column(:amenity, :boolean)
      t.column(:price, :integer)

      t.timestamps
    end
  end
end
