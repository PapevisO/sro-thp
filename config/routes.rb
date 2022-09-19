# frozen_string_literal: true

Rails.application.routes.draw do
  resources :blogs
  resources :groups, except: [:destroy] do
    post 'join' => 'groups#join'
    resources :blog_posts, controller: 'blogs', type: 'Blog::Post'
    resources :blog_comments, controller: 'blogs', type: 'Blog::Comment'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  devise_for :users, path: "auth", controllers: {
    registrations: "users/registrations",
    sessions:      "users/sessions",
    confirmations: "users/confirmations",
    passwords:     "users/passwords",
  }
end
