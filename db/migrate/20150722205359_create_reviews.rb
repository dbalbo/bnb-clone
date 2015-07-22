class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.column(:name, :string)
      t.column(:text, :string)
      t.column(:listing_id, :integer)
      t.column(:user_id, :integer)
      t.column(:rating, :integer)

      t.timestamps
    end
  end
end
