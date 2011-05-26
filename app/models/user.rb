class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :fbid, :presence => true
end
