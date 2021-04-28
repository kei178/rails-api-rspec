require 'rails_helper'

RSpec.describe 'Tasks request', type: :request do
  describe 'GET /api/v1/tasks' do
    let(:user) { create(:user) }

    it 'returns an array of tasks related to the user' do
      2.times { create(:task, user: user) }
      1.times { create(:task) }
      get '/api/v1/tasks', params: { user_id: user.id }

      json = JSON.parse(response.body)
      tasks = Task.where(user_id: user.id).as_json(except: %i[created_at updated_at])
      expect(json['tasks']).to eq(tasks)
      expect(json['tasks'].count).to eq(2)
    end

    it 'returns an empty array of tasks when user_id is not specified' do
      2.times { create(:task, user: user) }
      1.times { create(:task) }
      get '/api/v1/tasks'

      json = JSON.parse(response.body)
      expect(json['tasks']).to be_empty
    end
  end

  describe 'GET /api/v1/tasks/:id' do
    let(:task) { create(:task) }

    it 'returns a task' do
      get "/api/v1/tasks/#{task.id}"

      json = JSON.parse(response.body)
      expect(json['task']).to eq(task.as_json(except: %i[created_at updated_at]))
    end

    it 'returns 404 if not found' do
      expect { get '/api/v1/tasks/1' }.to raise_error(ActiveRecord::RecordNotFound)
    end  
  end
end
