Rails.application.routes.draw do
  put 'mycomment' => 'application#comment', as: :mycomment
  resources :comments

  resources :shows do
    get 'add', on: :member
    member do
      post 'add_to_current', to: "shows#create"
      get 'add_to_current', to: "shows#add_to_current"
    end
  end

  resources :songs do
    get 'add', on: :member
    member do
      post 'add_to_current', to: "songs#create"
      get 'add_to_current', to: "songs#add_to_current"
    end
  end
  resources :quotes do
    get 'add', on: :member
    member do
      post 'add_to_current', to: "quotes#create"
      get 'add_to_current', to: "quotes#add_to_current"
    end
  end
  resources :books do
    get 'add', on: :member
    member do
      post 'add_to_current', to: "books#create"
      get 'add_to_current', to: "books#add_to_current"
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
    end
  end
  resources :users
  resources :lists
  resources :admin

# correlate user profiles with username
  get 'about' => 'application#about'
  get 'explore' => 'profile#explore'
  get 'aprilkoh/edit' => 'profile#edit'
  put 'like' => 'application#like'
  put 'dislike' => 'application#dislike'
  post 'add_comment' => 'application#add_comment'

  root to: "profile#show"

  resources :users do
    resources :lists
    resources :profile do
      put 'follow', on: :collection
      get 'edit', on: :collection
      get 'show', on: :collection
      get 'change_current', on: :collection
      get 'add_on_mobile', on: :member
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
