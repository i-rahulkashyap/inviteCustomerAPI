module HaversineDistance
  EARTH_RADIUS_KM = 6371.0

  class InvalidCoordinateError < StandardError; end

  def self.distance(lat1, lon1, lat2, lon2)
    validate_coordinates(lat1, lon1)
    validate_coordinates(lat2, lon2)

    d_lat = to_radians(lat2 - lat1)
    d_lon = to_radians(lon2 - lon1)

    a = Math.sin(d_lat / 2)**2 + Math.cos(to_radians(lat1)) * Math.cos(to_radians(lat2)) * Math.sin(d_lon / 2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    EARTH_RADIUS_KM * c
  end

  def self.to_radians(degrees)
    degrees * Math::PI / 180
  end

  private

  def self.validate_coordinates(lat, lon)
    unless lat.is_a?(Numeric) && lon.is_a?(Numeric)
      raise InvalidCoordinateError, "Coordinates must be numeric"
    end

    unless lat.between?(-90, 90) && lon.between?(-180, 180)
      raise InvalidCoordinateError, "Latitude must be between -90 and 90 and longitude must be between -180 and 180"
    end
  end
end