Rails.application.routes.draw do
  get 'templates/index'

  namespace :api, defaults: { format: :json } do
    resources :todo_lists, only: :show do
      resources :todos, except: [:index, :new, :edit, :show]
    end
  end
end
