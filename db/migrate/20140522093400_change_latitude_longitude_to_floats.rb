class ChangeLatitudeLongitudeToFloats < ActiveRecord::Migration
  def up
    change_column :pictures, :latitude, 'float USING CAST(latitude AS float)'
    change_column :pictures, :longitude, 'float USING CAST(longitude AS float)'
  end

  def down
    change_column :pictures, :latitude, 'string USING CAST(latitude AS string)'
    change_column :pictures, :longitude, 'string USING CAST(longitude AS string)'
  end
end
