class AddCategoryIdToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :category_id, :integer
  end
end
