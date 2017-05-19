class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :region
      t.string :category
      t.string :title
      t.text :description
      t.float :price
      t.string :image
      t.string :city
      t.integer :userId

      t.timestamps null: false
    end
  end
end
