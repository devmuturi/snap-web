require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  root "feed#show"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :listings, except: :index do
    scope module: :listings do
      post :draft, to: "drafts#create", on: :collection
      patch :draft, to: "drafts#update"
    end

    resource :saved_listings, only: [ :create, :destroy ], path: "save"
  end
  resource :my_listings, only: :show
  resource :saved_listings, only: :show
  mount Sidekiq::Web => "/sidekiq"
end
