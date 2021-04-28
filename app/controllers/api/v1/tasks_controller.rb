class Api::V1::TasksController < ApplicationController
  def index
    tasks = Task.all.to_json(except: %i[created_at updated_at])
    render json: { 'tasks' => tasks }
  end
end