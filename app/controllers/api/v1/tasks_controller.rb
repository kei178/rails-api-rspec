module Api
  module V1
    class TasksController < ApplicationController
      def index
        user_id = params[:user_id]
        tasks = Task.where(user_id: user_id)
        render json: TaskSerializer.new(tasks).serialized_json
      end

      def show
        task = Task.find(params[:id])
        render json: TaskSerializer.new(task).serialized_json
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: { 'status': 'ok' }
        else
          render json: {
            'status': 'error',
            'message': task.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        task = Task.find(params[:id])
        if task.update(task_params)
          render json: { 'status': 'ok' }
        else
          render json: {
            'status': 'error',
            'message': task.errors.full_messages
          }, status: :unprocessable_entity
          en
        end
      end

      private

      def task_params
        params.require(:task).permit(
          %i[user_id title is_completed]
        )
      end
    end
  end
end
