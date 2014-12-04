Rails.application.routes.draw do
  resources :products
  # booksやcomputersのパスでもProductsControllerを使うように設定する
  resources :books,     controller: :products
  resources :computers, controller: :products

  root "products#index"
end
