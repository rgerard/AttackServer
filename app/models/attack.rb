class Attack < ActiveRecord::Base
  validates :attack_name, :presence => true
  validates :attack_image, :presence => true
end
