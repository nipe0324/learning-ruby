Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :todo_lists, except: [:new, :edit] do
      resources :todos, except: [:new, :edit, :show]
    end
  end

  get '/dashboard'      => 'templates#index'
  get '/todo_lists/:id' => 'templates#index'
  get '/templates/:path.html' => 'templates#template', constraints: { path: /.+/ }

  root 'templates#index'
end
