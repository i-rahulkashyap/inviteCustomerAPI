require_relative 'haversine_distance'

class InviteCustomersService
  OFFICE_COORDINATES = [19.0590317, 72.7553452].freeze
  MAX_DISTANCE_KM = 100

  def initialize(file)
    @file = file
  end

  def call
    customers = parse_file
    nearby_customers = filter_customers(customers)
    sort_customers(nearby_customers)
  end
  private

  def parse_file
    customers = []
    File.foreach(@file.path) do |line|
      customers << JSON.parse(line)
    end
    customers
  end

  def filter_customers(customers)
    customers.select do |customer|
      distance_to_office(customer['latitude'].to_f, customer['longitude'].to_f) <= MAX_DISTANCE_KM
    end
  end

  def distance_to_office(lat, lon)
    HaversineDistance.distance(lat, lon, *OFFICE_COORDINATES)
  end

  def sort_customers(customers)
    customers.sort_by { |customer| customer['user_id'] }
  end
end
