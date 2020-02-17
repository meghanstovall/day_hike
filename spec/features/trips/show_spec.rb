require 'rails_helper'

RSpec.describe "hiking trips show page" do

  # User story 3
  it "can see list of trails included in this trip along with that trails info" do
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

    visit "/trips/#{trip_1.id}"

    expect(page).to have_content(trail_1.name)
    expect(page).to have_content("Address: #{trail_1.address}")
    expect(page).to have_content("Length of Trail: #{trail_1.length} miles")
    expect(page).to have_content(trail_2.name)
    expect(page).to have_content("Address: #{trail_2.address}")
    expect(page).to have_content("Length of Trail: #{trail_2.length} miles")
    expect(page).to have_content(trail_3.name)
    expect(page).to have_content("Address: #{trail_3.address}")
    expect(page).to have_content("Length of Trail: #{trail_3.length} miles")
  end

  # User story 4
  it "can see total hiking distance" do
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

    visit "/trips/#{trip_1.id}"

    expect(page).to have_content("Total Hiking Distance: 35 miles")
  end

  # User story 5
  it "can see average hiking distance" do
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

    visit "/trips/#{trip_1.id}"

    expect(page).to have_content("Average Hiking Distance: 12.0 miles")
  end

  # User story 6
  it "can see heading for longest trail on the trip" do
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

    visit "/trips/#{trip_1.id}"

    within "#trail-#{trail_1.id}" do
      expect(page).to have_content("Longest Trail on Trip")
    end
  end

  # User story 7
  it "can see heading for shortest trail on the trip" do
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

    visit "/trips/#{trip_1.id}"

    within "#trail-#{trail_3.id}" do
      expect(page).to have_content("Shortest Trail on Trip")
    end
  end

  # User story 8
  it "can click a trail and go to that trails show page" do
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

    visit "/trips/#{trip_1.id}"

    within "#trail-#{trail_2.id}" do
      click_on "The View"
    end
    expect(current_path).to eq("/trips/#{trip_1.id}/trails/#{trail_2.id}")
    expect(page).to have_content(trail_2.name)
    expect(page).to have_content("Length: #{trail_2.length} miles")
    expect(page).to have_content("Address: #{trail_2.address}")
  end
end
