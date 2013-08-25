class Artifact < ActiveRecord::Base
  attr_accessible :name, :media

  belongs_to :artist
end
