require 'rails_helper'

describe Trail, type: :model do
  describe 'validations' do
    it { should validate_presence_of :length }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }

    it { should validate_numericality_of(:length).only_integer }
    it { should validate_numericality_of(:length).is_greater_than(0) }
  end

  describe 'relationships' do
    it {should have_many :trail_trips}
    it {should have_many(:trips).through(:trail_trips)}
  end

  describe '#total_distance' do
    it "can return total hiking distance of all its trails" do
      trip_1 = Trip.create({name: "Royal Arch",
                          start_date: Time.zone.now.to_datetime,
                          end_date: Time.zone.now.to_datetime})
      trail_1 = trip_1.trails.create({name: "Stairs",
                                    length: 20,
                                    address: "1234 Flatirons Ways"})
      trail_2 = trip_1.trails.create({name: "The View",
                                    length: 10,
                                    address: "50 Flatirons Street"})
      trail_3 = trip_1.trails.create({name: "Park",
                                    length: 5,
                                    address: "1 Flatirons Road"})

      expect(trip_1.trails.total_distance).to eq(35)
    end
  end

  describe '#average_distance' do
    it "can return total hiking distance of all its trails" do
      trip_1 = Trip.create({name: "Royal Arch",
                          start_date: Time.zone.now.to_datetime,
                          end_date: Time.zone.now.to_datetime})
      trail_1 = trip_1.trails.create({name: "Stairs",
                                    length: 20,
                                    address: "1234 Flatirons Ways"})
      trail_2 = trip_1.trails.create({name: "The View",
                                    length: 10,
                                    address: "50 Flatirons Street"})
      trail_3 = trip_1.trails.create({name: "Park",
                                    length: 6,
                                    address: "1 Flatirons Road"})

      expect(trip_1.trails.average_distance).to eq(12)
    end
  end

  describe '#longest_trail' do
    it "can return trail with longest difference" do
      trip_1 = Trip.create({name: "Royal Arch",
                          start_date: Time.zone.now.to_datetime,
                          end_date: Time.zone.now.to_datetime})
      trail_1 = trip_1.trails.create({name: "Stairs",
                                    length: 20,
                                    address: "1234 Flatirons Ways"})
      trail_2 = trip_1.trails.create({name: "The View",
                                    length: 10,
                                    address: "50 Flatirons Street"})
      trail_3 = trip_1.trails.create({name: "Park",
                                    length: 6,
                                    address: "1 Flatirons Road"})

      expect(trip_1.trails.longest_trail).to eq([trail_1])
    end
  end

  describe '#shortest_trail' do
    it "can return trail with longest difference" do
      trip_1 = Trip.create({name: "Royal Arch",
                          start_date: Time.zone.now.to_datetime,
                          end_date: Time.zone.now.to_datetime})
      trail_1 = trip_1.trails.create({name: "Stairs",
                                    length: 20,
                                    address: "1234 Flatirons Ways"})
      trail_2 = trip_1.trails.create({name: "The View",
                                    length: 10,
                                    address: "50 Flatirons Street"})
      trail_3 = trip_1.trails.create({name: "Park",
                                    length: 6,
                                    address: "1 Flatirons Road"})

      expect(trip_1.trails.shortest_trail).to eq([trail_3])
    end
  end

  describe '#num_hiking_trips' do
    it "can return number of trips trail is in" do
      trip_1 = Trip.create({name: "Royal Arch",
                          start_date: Time.zone.now.to_datetime,
                          end_date: Time.zone.now.to_datetime})
      trip_2 = Trip.create({name: "Trip",
                          start_date: Time.zone.now.to_datetime,
                          end_date: Time.zone.now.to_datetime})

      trail_1 = trip_1.trails.create({name: "Stairs",
                                    length: 20,
                                    address: "1234 Flatirons Ways"})
      trail_2 = trip_1.trails.create({name: "The View",
                                    length: 10,
                                    address: "50 Flatirons Street"})
      trail_3 = trip_1.trails.create({name: "Park",
                                    length: 6,
                                    address: "1 Flatirons Road"})
      trip_2.trails << trail_2
      trip_2.trails << trail_3

      expect(trail_3.num_hiking_trips).to eq(2)
    end
  end
end
