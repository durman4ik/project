Rails.application.routes.draw do

  get '/:locale' => "home#index"

  devise_for :users, skip: [:session, :password, :registration, :confirmation], 
              controllers: { omniauth_callbacks: 'omniauth_callbacks' }

 post "ajax" => "constructions#foo", as: :foo

  scope "(:locale)", locale: /ru|en/ do

    

    root to: "home#index"

    get "users/profile", as: "user_root"

    scope "/admin" do
      resources :users
    end

    post "/users/base_theme" => "users#current_theme"

    get "omniauth/:provider" => "omniauth#localized", as: :localized_omniauth
    devise_for :users, skip: :omniauth_callbacks, 
                controllers: { passwords: "passwords", registrations: "registrations" }

    delete "users/:id/profile" => "users#destroy", as: :admin_destroy_user
    get "users/admin_menu" => "users#admin_menu", as: :admin_menu

    
    resources :schemes  do
      resources :comments
      resources :constructions
    end  
    resources :ratings
    resources :elements
    resources :properties


    get "search" => "schemes#search", as: :search

  end

end
