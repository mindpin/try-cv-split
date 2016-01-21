Rails.application.routes.draw do
  resources :books
  resources :items
  get "/" => redirect("/books")
end
