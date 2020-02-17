require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :start_date}
    it {should validate_presence_of :end_date}
  end

  describe 'relationships' do
    it {should have_many :trail_trips}
    it {should have_many(:trails).through(:trail_trips)}
  end
end
