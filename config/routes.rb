Rails.application.routes.draw do
  resources :enrollments
  devise_for :users
  resources :courses do
    get :pending_review, on: :collection
    get :purchased, on: :collection
    # get :purchased, pending_review, on: :collection
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  get 'home/index'
  get 'activity', to: 'home#activity'
  root 'home#index'
end