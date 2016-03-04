Rails.application.routes.draw do
  resources :projects do
    resources :milestones, shalow: true, only: [:new, :create, :update]
    resources :invoices, shalow: true, except: [:index, :show]

    member do
      patch :archive
    end
  end

  resources :milestones, only: [:edit, :index, :destroy]

  get 'archived_projects', to: 'archived_projects#index'
  get 'outlook', to: 'outlook#index'

  root 'projects#index'
end
