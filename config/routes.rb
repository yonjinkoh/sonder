Rails.application.routes.draw do
  resources :comments
  resources :songs do
    get 'add', on: :member
    member do
      post 'add_to_current', to: "songs#create"
      get 'add_to_current', to: "songs#add_to_current"
      put "like", to: "songs#like"
      put "comment", to: "songs#comment"
      post "add_comment", to: "songs#add_comment"
    end
  end
  resources :quotes do
    get 'add', on: :member
    member do
      post 'add_to_current', to: "quotes#create"
      get 'add_to_current', to: "quotes#add_to_current"
      put "like", to: "quotes#like"
      put "comment", to: "quotes#comment"
      post "add_comment", to: "quotes#add_comment"
    end
  end
  resources :books do
    get 'add', on: :member
    member do
      post 'add_to_current', to: "books#create"
      get 'add_to_current', to: "books#add_to_current"
      put "like", to: "books#like"
      put "comment", to: "books#comment"
      post "add_comment", to: "books#add_comment"
    end
  end
  devise_for :admins, :controllers =>
  { sessions: 'admin/sessions' }
   devise_for :users,
    :controllers => {:registrations => "users/registrations"}
  resources :categories
  resources :movies do
    get 'add', on: :member
    member do
      post 'add_to_current', to: "movies#create"
      get 'add_to_current', to: "movies#add_to_current"
      put "like", to: "movies#like"
      put "comment", to: "movies#comment"
      post "add_comment", to: "movies#add_comment"
    end
  end
  resources :users
  resources :lists
  resources :admin

# correlate user profiles with username
  get 'about' => 'application#about'
  get 'explore' => 'profile#explore'
  get 'aprilkoh/edit' => 'profile#edit'
  root to: "profile#show"

  resources :users do
    resources :lists
    resources :profile do
      get 'edit', on: :collection
      get 'show', on: :collection
      get 'change_current', on: :collection
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  get '/:username', to: 'profile#show'

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
