Rails.application.routes.draw do

  root 'home#index'
  get 'home/index'
  get 'activity', to: 'home#activity'
  get 'analytics', to: 'home#analytics'

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
    resources :lessons, except: [:index] do
      resources :comments, except: [:index]
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create]
  end

  resources :youtube, only: :show
  
  resources :users, only: [:index, :edit, :show, :update]
  
  namespace :charts do
    get 'users_per_day'
    get 'enrollments_per_day'
    get 'course_popularity'
    get 'money_makers'
  end
end