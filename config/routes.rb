Rails.application.routes.draw do
  devise_for :users do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  root "home#index"

  resources :albums do
    get :add_photo, to: "albums#add_photo"
    patch :add_photo, to: "albums#add_photo"
    get "all_albums", to: "albums#all_albums", on: :collection
    resources :likes
    resources :photos
  end

  resources :home do
    collection do
      match "search" => "home#search", via: %i[get post], as: :search
    end
  end
  get "search", to: "albums#search"
  resources :home
  resources :tags
end
