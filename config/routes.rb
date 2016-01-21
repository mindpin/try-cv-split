Rails.application.routes.draw do
  resources :posts
  resources :items
  get "/" => redirect("/posts")
end
