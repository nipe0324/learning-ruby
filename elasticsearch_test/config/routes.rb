Rails.application.routes.draw do
  root 'top#index'
  get  'top/suggest', to: 'top#suggest', defaults: { format: 'json' }
end
