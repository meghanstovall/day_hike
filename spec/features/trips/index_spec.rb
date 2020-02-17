require 'rails_helper'

RSpec.describe "hiking trip index page" do

  # User story 1
  it "can see list of all trip names" do
    trip_1 = Trip.create({name: "Royal Arch",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})
    trip_2 = Trip.create({name: "Flatirons",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})
    trip_3 = Trip.create({name: "14er",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})

    visit "/trips"

    expect(page).to have_content("Royal Arch")
    expect(page).to have_content("Flatirons")
    expect(page).to have_content("14er")
  end

  # User story 2
  it "can click on name of trip and sent to its show page" do
    trip_1 = Trip.create({name: "Royal Arch",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})
    trip_2 = Trip.create({name: "Flatirons",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})
    trip_3 = Trip.create({name: "14er",
                        start_date: Time.zone.now.to_datetime,
                        end_date: Time.zone.now.to_datetime})

    visit "/trips"

    expect(page).to have_link("Royal Arch")
    expect(page).to have_link("Flatirons")
    expect(page).to have_link("14er")

    within "#trip-#{trip_1.id}" do
      click_on "Royal Arch"
    end
    expect(current_path).to eq("/trips/#{trip_1.id}")

    expect(page).to have_content("Royal Arch")
  end
end
