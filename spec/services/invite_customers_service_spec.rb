require 'rails_helper'

RSpec.describe InviteCustomersService do
  let(:file) { fixture_file_upload(Rails.root.join('public', 'customers.txt'), 'text/plain') }

  describe '#call' do
    it 'returns sorted customers within 100km of the office' do
      service = InviteCustomersService.new(file)
      result = service.call

      expect(result).to be_an(Array)
      expect(result).to all(include('user_id', 'name'))
      expect(result.first['user_id']).to be < result.last['user_id']
    end
  end
end