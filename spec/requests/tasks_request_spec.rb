require 'rails_helper'

RSpec.describe 'Tasks request', type: :request do
  describe 'GET /api/v1/tasks' do
    let(:user) { create(:user) }

    it 'returns an array of tasks related to the user' do
      2.times { create(:task, user: user) }
      2.times { create(:task) }
      get '/api/v1/tasks', params: { user_id: user.id }

      json = JSON.parse(response.body)
      tasks = Task.where(user_id: user.id).as_json(except: %i[created_at updated_at])
      expect(json['tasks']).to eq(tasks)
      expect(json['tasks'].count).to eq(2)
    end

    it 'returns an empty array of tasks when user_id is not specified' do
      2.times { create(:task, user: user) }
      2.times { create(:task) }
      get '/api/v1/tasks'

      json = JSON.parse(response.body)
      expect(json['tasks']).to be_empty
    end
  end
end
