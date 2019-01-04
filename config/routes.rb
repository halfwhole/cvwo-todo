Rails.application.routes.draw do
  root 'todos#index'
  resources :todos do
    member do
      patch 'complete'
      patch 'priority'
      patch 'tag'
    end
  end
end
