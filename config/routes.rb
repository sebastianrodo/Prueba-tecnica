Rails.application.routes.draw do
  devise_for :users

  resources :csvs, except: :index do
    resources :contacts, only: [:create, :index], controller: 'csvs/contacts'
  end

  resource :users, only: [] do
    resources :contacts, only: :index, controller: 'users/contacts'
    resources :csvs, only: :index, controller: 'users/csvs'
  end

  root to: "users/contacts#index"
end
