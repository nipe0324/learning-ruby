Rails.application.routes.draw do
  root 'products#index'
  resources 'products', only: :index do
    collection { post :import }
  end
end
