Rails.application.routes.draw do

  root 'products#index'

  resources 'products', only: :index do
    collection do
      get  :export
      post :import
    end
  end
end
