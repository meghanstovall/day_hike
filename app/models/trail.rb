class Trail < ApplicationRecord
  validates_presence_of :name, :address, :length
  validates_numericality_of :length, only_integer: true, greater_than: 0

  has_many :trail_trips
  has_many :trips, through: :trail_trips

  def self.total_distance
    Trail.sum(:length)
  end

  def self.average_distance
    Trail.average(:length)
  end

  def self.longest_trail
    Trail.order(length: :desc).limit(1)
  end

  def self.shortest_trail
    Trail.order(:length).limit(1)
  end

  def num_hiking_trips
    trips.count
  end
end
