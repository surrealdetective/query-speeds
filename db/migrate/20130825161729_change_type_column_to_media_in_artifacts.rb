class ChangeTypeColumnToMediaInArtifacts < ActiveRecord::Migration
  def change
    rename_column :artifacts, :type, :media
  end
end
