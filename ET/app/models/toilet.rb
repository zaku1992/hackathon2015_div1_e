class Toilet < ActiveRecord::Base
  belongs_to :user
  has_many   :evaluations

  def self.mens(now_lat, now_long, dist = 0.02)
    @toilets = Toilet.joins(:user).where(users: { sex: false })
                     .where('long < ? + ?', now_long, dist)
                     .where('long > ? - ?', now_long, dist)
                     .where('lat < ? + ?', now_lat, dist)
                     .where('lat > ? - ?', now_lat, dist)
  end

  def self.womens(now_lat, now_long, dist = 0.02)
    @toilets = Toilet.joins(:user).where(users: { sex: true })
                     .where('long < ? + ?', now_long, dist)
                     .where('long > ? - ?', now_long, dist)
                     .where('lat < ? + ?', now_lat, dist)
                     .where('lat > ? - ?', now_lat, dist)
  end
end
