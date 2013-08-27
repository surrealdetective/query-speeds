class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.integer :artist_id
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end
