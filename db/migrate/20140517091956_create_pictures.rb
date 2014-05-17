class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :user
      t.string :name
      t.text :image
      t.datetime :datetime
      t.string :latitude
      t.string :longitude
      t.decimal :altitude
      t.integer :image_length
      t.integer :image_height
      t.integer :orientation
      t.string :camera_make
      t.string :camera_model
      t.integer :exposure
      t.boolean :flash
      t.decimal :focal_length

      t.timestamps
    end
    add_index :pictures, :user_id
  end
end
