PhotoSharingApp::Application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  # intial home root to album#index until User Model & Homepage is created

  get 'tags/:tag', to: 'pictures#search', as: :tag
  get '/search_results/', to: "pictures#search", as: :search_results
  get '/album/:id/like', to: "albums#like", as: :album_like
  get '/album/:id/dislike', to: "albums#dislike", as: :album_dislike
  get '/picture/:id/like', to: "pictures#like", as: :picture_like
  get '/picture/:id/dislike', to: "pictures#dislike", as: :picture_dislike

  resources :home, only: [:index], as: '/'

  resources :admin, only: [:index], as: 'admin'

  resources :albums do
    resources :pictures do
      member do
        get 'inappropriate'
        delete 'delete_inappropriate', as: :delete_inappropriate
      end
      resources :comments do
        member do
          get 'inappropriate'
          delete 'delete_inappropriate', as: :delete_inappropriate
        end
      end
    end
    resources :comments do
      member do
        get 'inappropriate'
        delete 'delete_inappropriate', as: :delete_inappropriate
      end
    end
  end

  resources :users

  get '/pages/*id' => 'pages#show', as: :page, format: false

  root to: "home#index"

  


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
