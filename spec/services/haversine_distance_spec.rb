require 'rails_helper'

RSpec.describe HaversineDistance, type: :module do
  describe '.distance' do
    it 'calculates the distance between two coordinates' do
      lat1, lon1 = 19.0590317, 72.7553452
      lat2, lon2 = -68.850431, -35.814792
      distance = HaversineDistance.distance(lat1, lon1, lat2, lon2)

      expect(distance).to be_within(0.1).of(12721) # Approx 12721 km
    end

    it 'returns 0 for the same coordinates' do
      lat, lon = 19.0590317, 72.7553452
      distance = HaversineDistance.distance(lat, lon, lat, lon)

      expect(distance).to eq(0)
    end
  end
end
