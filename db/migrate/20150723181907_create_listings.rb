class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.column :name, :string
      t.column :location, :string
      t.column :user_id, :integer
      t.attachment :image
      t.column :description, :string
      t.column :price, :integer
      t.column :guest_number, :string
      t.column :toilet, :string
      t.column :shower, :string
      t.column :outlet, :string
      t.column :pets, :string


      t.timestamps
    end
  end
end
