Rails.application.routes.draw do
  resources :challenges
  resources :tasks
  get  "tasks/:id/ide", to: "tasks#ide", as: :ide
  resources :rooms
  resources :room_requests, only: [:new, :create]
  get  "r/:code", to: "room_requests#new", as: :room_request
  get  "room_request_success", to: "room_requests#success", as: :success_room_request
  get  "rooms/:id/select", to: "rooms#select", as: :select_room

  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  post "change_context", to: "sessions#change_context"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource  :password, only: [:edit, :update]
  namespace :identity do
    resource :email,              only: [:edit, :update]
    resource :email_verification, only: [:show, :create]
    resource :password_reset,     only: [:new, :edit, :create, :update]
  end
  post "sign_in", to: "sessions#create"
  post "become_teacher", to: "professors#become_teacher"

  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "home/index"
  root "home#index"

  mount SolidQueueDashboard::Engine, at: "/solid-queue"
  get "up" => "rails/health#show", as: :rails_health_check
  get 'codicon.ttf', to: redirect('https://cdn.jsdelivr.net/npm/monaco-editor@0.45.0/esm/vs/base/browser/ui/codicons/codicon/codicon.ttf')
end
