class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :artifacts
  has_many :artists, :through => :artifacts
end
