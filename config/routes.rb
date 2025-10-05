Rails.application.routes.draw do
  root "feed#show"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :listings, except: :index
end
