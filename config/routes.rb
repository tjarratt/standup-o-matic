# frozen_string_literal: true

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails
  .application
  .routes
  .draw do
    root to: redirect('standups/today')

    resources :backmakers
    resources :standups do
      resources :interestings

      get 'present', action: 'present'
    end
  end
