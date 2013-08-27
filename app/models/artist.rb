class Artist < ActiveRecord::Base
  attr_accessible :name

  has_many :artifacts
  has_many :categories, :through => :artifacts
  has_many :commissions
end
