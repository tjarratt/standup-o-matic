# frozen_string_literal: true

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails
  .application
  .routes
  .draw do
    root to: redirect('standups/today')

    resources :backmakers
    resources :events

    resources :emcees do
      put 'current', action: 'update'
    end

    resources :standups do
      resources :interestings
      resources :moment_of_zen

      get 'present', action: 'present'
      post 'nominate', action: 'nominate'
    end
  end
