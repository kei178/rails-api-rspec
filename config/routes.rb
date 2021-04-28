Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/status' => 'status#index'
      resources :tasks, only: %i[index]
    end
  end
end
