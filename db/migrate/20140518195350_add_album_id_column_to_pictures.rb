class AddAlbumIdColumnToPictures < ActiveRecord::Migration
  def self.up
    remove_column :pictures, :user_id
    add_column :pictures, :album, :references
    
    add_index :pictures, :album_id
    remove_index :pictures, :user_id
  end

  def self.down
    add_column :pictures, :user, :references
    remove_column :pictures, :album_id
    
    add_index :pictures, :user_id
    remove_index  :pictures, :user_id
  end
end
