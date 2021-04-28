require 'rails_helper'

RSpec.describe 'Tasks request' do
  describe 'GET /api/v1/tasks' do
    it 'returns an array of tasks' do
      get '/api/v1/tasks'
      json = JSON.parse(response.body)
      expect(json['tasks']).to eq(JSON.parse([
        {
          "userId": 1,
          "id": 1,
          "title": "delectus aut autem",
          "completed": false
        },
        {
          "userId": 1,
          "id": 2,
          "title": "quis ut nam facilis et officia qui",
          "completed": false
        },
        {
          "userId": 1,
          "id": 3,
          "title": "fugiat veniam minus",
          "completed": false
        }
      ].to_json))
    end
  end
end
