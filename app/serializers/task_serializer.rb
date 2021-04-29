class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :title, :is_completed
end
