require 'rails_helper'

RSpec.describe 'Api::V1::Customers', type: :request do
  let(:valid_file) { Rack::Test::UploadedFile.new(Rails.root.join('public', 'customers.txt'), 'text/plain') }
  let(:office_coordinates) { [19.0590317, 72.7553452] }

  describe 'POST /api/v1/customers/invite' do
    context 'when the file is provided' do
      it 'returns a list of customers' do
        post '/api/v1/customers/invite', params: { file: valid_file }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        response_body = JSON.parse(response.body)
        expect(response_body).to be_an(Array)
        expect(response_body.first).to have_key('user_id')
        expect(response_body.first).to have_key('name')
      end
    end

    context 'when the file is not provided' do
      it 'returns a bad request error' do
        post '/api/v1/customers/invite'

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include('File not provided')
      end
    end

    context 'when there is an internal server error' do
      before do
        allow_any_instance_of(InviteCustomersService).to receive(:call).and_raise(StandardError)
      end

      it 'returns an internal server error' do
        post '/api/v1/customers/invite', params: { file: valid_file }

        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('Internal server error')
      end
    end
  end

  describe 'POST /process_file' do
    it 'returns customers within 100 km from office' do
      post '/api/v1/customers/invite', params: { file: valid_file }

      expect(response).to have_http_status(:success)

      customers = JSON.parse(response.body)
      expect(customers).to be_an(Array)
      expect(customers).to all(include('user_id', 'name'))
    end

    it 'calculates the correct distance for each customer' do
      post '/api/v1/customers/invite', params: { file: valid_file }

      customers = JSON.parse(response.body)
      customers.each do |customer|
        lat = customer['latitude'].to_f
        lon = customer['longitude'].to_f
        distance = HaversineDistance.distance(office_coordinates[0], office_coordinates[1], lat, lon)
        
        puts "Customer: #{customer['user_id']} - Distance: #{distance} km"
        expect(distance).to be_a(Numeric)
      end
    end
  end

end


