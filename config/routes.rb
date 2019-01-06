Rails.application.routes.draw do
  root 'todos#index'
  resources :todos do
    member do
      patch 'complete'
      patch 'priority'
      patch 'add_tag'
      patch 'remove_tag'
    end
    collection do
      post 'add_search_tag'
      post 'remove_search_tag'
    end
  end
end
