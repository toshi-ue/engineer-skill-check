# frozen_string_literal: true

Rails.application.routes.draw do
  root 'employees#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :employees do
    resources :profiles, except: %i[index]
  end
  resources :articles
end
