Rails.application.routes.draw do
  get "about", to: "home#about"  
  get "contact", to: "home#contact"  
  root "home#index"
end
