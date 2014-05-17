class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.text :profile_pic
      t.string :role
      t.text :bio
      t.text :url

      t.timestamps
    end
  end
end
