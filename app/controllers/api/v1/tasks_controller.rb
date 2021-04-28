class Api::V1::TasksController < ApplicationController
  def index
    user_id = params[:user_id]
    tasks = Task.where(user_id: user_id)
                .as_json(except: %i[created_at updated_at])
    render json: { 'tasks' => tasks }
  end

  def show
    task = Task.find(params[:id])
               .as_json(except: %i[created_at updated_at])
    render json: { 'task' => task }
  end
end