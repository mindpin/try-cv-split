Rails.application.routes.draw do
  resources :posts do
    resources :book
  end
  resources :items
  get "/" => redirect("/posts")

  put '/xmdm/:xmdm', to: 'home#xmdm'
  get '/xmdm/:xmdm', to: 'home#xmdm', as: 'aaa'
  put '/xmdm/:xmdm', to: 'home#xmdm'
  get '/xmdm/:xmdm', to: 'home#xmdm', as: 'bbb'
  put '/xmdm/:xmdm', to: 'home#xmdm'
  post '/xmdm/:xmdm', to: 'home#xmdm', as: 'ccc'
end
