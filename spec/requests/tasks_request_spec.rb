require 'rails_helper'

RSpec.describe 'Tasks request', type: :request do
  describe 'GET /api/v1/tasks' do
    let(:user) { create(:user) }

    it 'returns an array of tasks related to the user' do
      2.times { create(:task, user: user) }
      create(:task)
      get '/api/v1/tasks', params: { user_id: user.id }

      json = JSON.parse(response.body)
      tasks = Task.where(user_id: user.id)
      expect(response.body).to eq(TaskSerializer.new(tasks).serialized_json)
      expect(json['data'].count).to eq(2)
    end

    it 'returns an empty array of tasks when user_id is not specified' do
      2.times { create(:task, user: user) }
      create(:task)
      get '/api/v1/tasks'

      json = JSON.parse(response.body)
      expect(json['data']).to be_empty
    end
  end

  describe 'GET /api/v1/tasks/:id' do
    let(:task) { create(:task) }

    it 'returns a task' do
      get "/api/v1/tasks/#{task.id}"

      expect(response.body).to eq(TaskSerializer.new(task).serialized_json)
    end

    it 'returns 404 if not found' do
      expect { get '/api/v1/tasks/1' }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST /api/v1/tasks' do
    it 'creates a task' do
      user = create(:user)
      params = {
        task: {
          user_id: user.id,
          title: 'demo task title',
          is_completed: false
        }
      }.to_json

      post '/api/v1/tasks',
           params: params,
           headers: { 'CONTENT_TYPE': 'application/json' }

      expect(response.status).to eq(200)
      expect(user.tasks.count).to eq(1)
    end

    it 'returns 422 error if params is invalid' do
      params = {
        task: {
          user_id: 1,
          title: 'demo task title',
          is_completed: false
        }
      }.to_json

      post '/api/v1/tasks',
           params: params,
           headers: { 'CONTENT_TYPE': 'application/json' }

      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/v1/tasks/:id' do
    let(:task) { create(:task) }
    let(:params) do
      {
        task: {
          title: 'updated demo task title'
        }
      }.to_json
    end
    it 'updates a task' do
      put "/api/v1/tasks/#{task.id}",
          params: params,
          headers: { 'CONTENT_TYPE': 'application/json' }

      task.reload
      expect(response.status).to eq(200)
      expect(task.title).to eq('updated demo task title')
    end

    it 'returns 404 if not found' do
      expect do
        put '/api/v1/tasks/1',
            params: params,
            headers: { 'CONTENT_TYPE': 'application/json' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
