Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :campgrounds, :campsites, :bookings, except: [:edit]
  get 'available_campgrounds', to: 'campgrounds#available'
end
