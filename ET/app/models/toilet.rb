class Toilet < ActiveRecord::Base
  belongs_to :user
  has_many   :evaluations

  def self.mens(now_lat, now_long, dist = 0.02)
    @toilets = Toilet.joins(:user)
                     .where('user.sex = 0')
                     .where('long < ? + ?', now_long, dist)
                     .where('long > ? - ?', now_long, dist)
                     .where('lat < ? + ?', now_lat, dist)
                     .where('lat > ? - ?', now_lat, dist)
                     .preload(:user)
  end

  def self.womens(now, dist = 0.02)
    @toilets = Toilet.joins(:user)
                     .where('user.sex = 1')
                     .where('long < ? + ?', now_long, dist)
                     .where('long > ? - ?', now_long, dist)
                     .where('lat < ? + ?', now_lat, dist)
                     .where('lat > ? - ?', now_lat, dist)
                     .preload(:user)
  end
end
