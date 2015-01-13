Rails.application.routes.draw do
  get 'templates/index'

  namespace :api, defaults: { format: :json } do
    resources :todo_lists, only: [:index, :show, :create, :destroy] do
      resources :todos, except: [:index, :new, :edit, :show]
    end
  end

  get '/templates/dashboard' => 'templates#dashboard'
  get '/templates/todo_list' => 'templates#todo_list'
  root 'templates#index'
end
