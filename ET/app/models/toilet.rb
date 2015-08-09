class Toilet < ActiveRecord::Base
  belongs_to :user
  has_many   :evaluations
  
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
end
