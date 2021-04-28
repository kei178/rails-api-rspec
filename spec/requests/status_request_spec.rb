require 'rails_helper'

RSpec.describe 'Status requests' do
  describe 'GET /api/v1/status' do
    it 'returns a status message' do
      get('/api/v1/status')
      json = JSON.parse(response.body)
      expect(json['status']).to eq('ok')
      expect(response.status).to eq(200)
    end
  end
end
