Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  get "dashboard", to: "dashboard#index"
  get "about", to: "home#about"
  get "contact", to: "home#contact"
  root "home#index"
end
