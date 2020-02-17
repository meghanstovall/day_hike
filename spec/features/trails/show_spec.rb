require 'rails_helper'

RSpec.describe "trail show page" do
  # User story 9
  it "can see name and address of trail as well as name and total length of all its hiking trips" do
    trip_1 = Trip.create({name: "Royal Arch",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})
    trip_2 = Trip.create({name: "Trip",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})
    trip_3 = Trip.create({name: "Arch",
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

    trip_3.trails << trail_3

    visit "/trails/#{trail_3.id}"

    expect(page).to have_content(trail_3.name)
    expect(page).to have_content("Address: #{trail_3.address}")
    expect(page).to have_content("Hiking Trips:")

    within "#trip-#{trip_1.id}" do
      expect(page).to have_content(trip_1.name)
      expect(page).to have_content("Total Length: 36 miles")
    end

    within "#trip-#{trip_2.id}" do
      expect(page).to have_content(trip_2.name)
      expect(page).to have_content("Total Length: 16 miles")
    end

    within "#trip-#{trip_3.id}" do
      expect(page).to have_content(trip_3.name)
      expect(page).to have_content("Total Length: 6 miles")
    end
  end

  # User story 10
  it "can see total number of hiking trips the trail is included in" do
    trip_1 = Trip.create({name: "Royal Arch",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})
    trip_2 = Trip.create({name: "Trip",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})
    trip_3 = Trip.create({name: "Arch",
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

    trip_3.trails << trail_3

    visit "/trails/#{trail_3.id}"

    expect(page).to have_content("Total number of hiking trips: 3")
  end
end
