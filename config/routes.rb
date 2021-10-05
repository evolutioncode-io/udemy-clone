Rails.application.routes.draw do
  resources :enrollments do
    get :my_students, on: :collection
  end
  devise_for :users
  resources :courses do
    get :pending_review, on: :collection
    get :purchased, on: :collection
    get :created, :unapproved, on: :collection
    member do
      get :analytics
      patch :approve
      patch :unapprove
    end
    resources :lessons do
      put :sort
    end
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  root 'home#index'
  get 'home/index'
  get 'activity', to: 'home#activity'
  get 'analytics', to: 'home#analytics'

  namespace :charts do
    get 'users_per_day'
    get 'enrollments_per_day'
    get 'course_popularity'
    get 'money_makers'
  end
  
  
end