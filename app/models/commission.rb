class Commission < ActiveRecord::Base
  attr_accessible :artist_id, :description, :price

  belongs_to :artist
end
