class Post < ActiveRecord::Base
  attr_accessible :name, :secret
  validates :name, :presence => true
end
