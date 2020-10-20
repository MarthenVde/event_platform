Rails.application.routes.draw do

  resources :zoom_users
  # Host event
  get 'home', to: 'home#index', as: :'home'
  get 'register-to-host', to: 'event_admins#new_event_and_admin', as: :'new_register_to_host'
  post 'register-to-host', to: 'event_admins#create_event_and_admin', as: :'create_register_to_host'
  get 'apply-to-host-event', to: 'event_admins#new_event_for_user', as: :'new_apply_to_host_event'
  post 'apply-to-host-event', to: 'event_admins#create_event_for_user', as: :'create_apply_to_host_event'
  devise_for :users, :skip => [:registrations] 
  resources :events do
    resources :companies, path: 'exhibitors' do
      post 'contact', to: 'companies#send_message', as: 'send_message'
      post 'rating', to: 'companies#rating', as: 'rating'
      post 'assist', to: 'companies#assist', as: 'assist'
     

    end
    resources :presentations
    resources :workshops do
      post 'rating', to: 'workshops#rating', as: 'rating'
    end
    resources :apply_to_exhibit
    member do
      devise_scope :user do
        get 'sign_in', to: 'events/sessions#new', as: :sign_in_new
        post 'sign_in', to: 'events/sessions#create', as: :sign_in_create
        get 'sign_out', to: 'events/sessions#destroy'
        get 'password/new', to: 'events/passwords#new', as: :password_new
        get 'password/edit', to: 'events/passwords#edit', as: :password_edit
        patch 'password', to: 'events/passwords#update', as: :password_update_patch
        put 'password', to: 'events/passwords#update', as: :password_update_put
        post 'password', to: 'events/passwords#create', as: :password_create
      end
      post 'join'
      get 'register-to-attend', to: 'apply_to_attend#new_user', as: :'new_user_for'
      post 'register-to-attend', to: 'apply_to_attend#create_user', as: :'create_user_for'
      # when user is not signed in, and wants to exhibit: create Company and User (link Company and User via CompanyExhibitor)
      get 'register-to-exhibit', to: 'apply_to_exhibit#new_company_and_user', as: :'new_user_and_company_for'
      post 'register-to-exhibit', to: 'apply_to_exhibit#create_company_and_user', as: :'create_user_and_company_for'
      # when user is signed in, and wants to exhibit: create Company (link existing User with with new Company via CompanyExhibitor)
      get 'apply-to-exhibit', to: 'apply_to_exhibit#new_company_for_user', as: :'new_exhibit_for'
      post 'apply-to-exhibit', to: 'apply_to_exhibit#create_company_for_user', as: :'create_exhibit_for'
      get 'about', to: 'events#about', as: 'about'
      get 'gallery', to: 'events#gallery', as: 'gallery'
      get 'who-should-attend', to: 'events#who_should_attend', as: 'who-should-attend'
      get 'faq', to: 'events#faq', as: 'faq'
      get 'terms-and-conditions', to: 'events#terms_and_conditions', as: 'terms_and_conditions'
      get 'contact', to: 'events#contact', as: 'contact'
      post 'contact', to: 'events#send_message', as: 'send_message'
      
    end
  end
 
 
  namespace :admin do
    resources :settings
  end
  resources :chats
  
  root to: "home#default_event"
  # root to: "home#index"
  # root to: "events#index"
  
  resources :users
  get '/user' => "events#index", :as => :user_root
  get 'packages', to: 'packages#index'
  resources :faqs
  get 'speaker-information', to: 'speaker_information#index'
  get 'home-logged-in', to: 'home_logged_in#index'
  get 'presenters', to: 'presenters#index'
  get 'contact', to: 'contact#index'
  get 'province',to: 'search#province'
  get 'city',to: 'search#city'
 


  get 'about', to: 'about#index'
  get 'faq', to: 'faq#index'
  get 'how-virtual-expos-work', to: 'virtual_expo_info#index'
  post 'site-files', to: 'site_files#upload', as: 'site_files'
end
