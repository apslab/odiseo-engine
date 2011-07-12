Rails.application.routes.draw do
  resources :companies

  resources :exercises do
    collection do
      get 'opened'
      get 'closed'
      get 'from_date'
    end

    resources :accounts do
      collection do
        get 'archived'
      end

      resources :accounts
      resource :report, :only => [:new, :create], :controller => 'odiseo/reports'

    end
  end

  resource :balance_report, :only => [:new, :create], :controller => 'odiseo/balance_reports'
  resource :general_balance_report, :only => [:new, :create], :controller => 'odiseo/general_balance_reports'
  resource :report_date, :only => [:new, :create], :controller => 'odiseo/report_dates'

  resources :accounts do
    collection do
      get 'archived'
    end

    resources :accounts
    resource :report, :only => [:new, :create], :controller => 'odiseo/reports'

  end

  resources :entries
end

