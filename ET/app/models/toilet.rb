class Toilet < ActiveRecord::Base
  belongs_to :user
  has_many   :evaluations

  def self.mens(now, dist = 0.02)
    @toilets = Toilet.joins(:user)
                     .where('user.sex = 0')
                     .where('long < ? + ?', now, dist)
                     .where('long > ? - ?', now, dist)
                     .where('lat < ? + ?', now, dist)
                     .where('lat > ? - ?', now, dist)
                     .preload(:user)
  end

  def self.womens(now, dist = 0.02)
    @toilets = Toilet.joins(:user)
                     .where('user.sex = 1')
                     .where('long < ? + ?', now, dist)
                     .where('long > ? - ?', now, dist)
                     .where('lat < ? + ?', now, dist)
                     .where('lat > ? - ?', now, dist)
                     .preload(:user)
  end
end
