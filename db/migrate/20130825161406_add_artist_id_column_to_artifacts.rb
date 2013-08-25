class AddArtistIdColumnToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :artist_id, :integer
  end
end
