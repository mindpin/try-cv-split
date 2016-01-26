Rails.application.routes.draw do
  resources :books, :shallow => true do
    resources :comments
  end
  resources :items
  get "/" => redirect("/books")
end
