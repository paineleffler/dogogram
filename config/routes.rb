Rails.application.routes.draw do
  resources :posts
  root 'posts#index' #controller then action
end
