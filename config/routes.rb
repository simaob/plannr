Rails.application.routes.draw do
  resources :users do
    resources :rosters, only: [:new, :create]
  end
  resources :sessions
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :clients
  resources :reports
  resources :projects do
    resources :milestones, shalow: true, only: [:new, :create, :update]
    resources :invoices, shalow: true, except: [:index, :show]

    member do
      patch :archive
    end
  end
  resources :milestones, only: [:edit, :index, :destroy]
  resources :invoices, only: [:index, :destroy, :edit]

  resources :rosters, only: [:destroy]
  resources :teams

  get 'archived_projects', to: 'archived_projects#index'
  get 'outlook', to: 'outlook#index'

  root 'projects#index'
end
