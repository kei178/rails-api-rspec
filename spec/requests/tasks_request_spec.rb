require 'rails_helper'

RSpec.describe 'Tasks request', type: :request do
  describe 'GET /api/v1/tasks' do
    it 'returns an array of tasks' do
      3.times { create(:task) }
      tasks = Task.all.to_json(except: %i[created_at updated_at])
      get '/api/v1/tasks'
      json = JSON.parse(response.body)
      expect(json['tasks']).to eq(JSON.parse(tasks.to_json))
    end
  end
end
