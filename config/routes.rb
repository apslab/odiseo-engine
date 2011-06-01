Rails.application.routes.draw do
  resources :companies
  
  resources :exercises do
    collection do
      get 'opened'
      get 'closed'
    end
  end

  resources :accounts do
    collection do
      get 'archived'
    end

    resources :accounts

    member do
      get 'print_movim', :action => :print_movim
    end
  end

  resources :entries
end