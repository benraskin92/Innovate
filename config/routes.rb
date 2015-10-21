Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#home'
  get '/contact' => 'static_pages#contact'
  get '/about' => 'static_pages#about'

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
  end

   devise_scope :user do
    get "/signup" => "devise/registrations#new"
  end

  get 'add_challenge' => 'challenges#new'
  get 'challenges' => 'challenges#index'
  get '/challenges/:challenge_id/solutions/add_solution' => 'solutions#new'
  get 'users/:id' => 'users#show'
  get 'search' => 'challenges#search_index'
  get '/category_search/:id/:category' => 'challenges#search_category'
  post '/challenges/add_top_three' => 'challenges#add_top_three'
  get '/challenges/:challenge_id/edit' => 'challenges#edit'
  post '/challenges/voting_stage' => 'challenges#voting_stage'
  post '/solutions/top_flag' => 'solutions#top_flag'
  post '/challenges/participate_stage' => 'challenges#participate_stage'


  resources :challenges do
    resources :solutions
    member do
    get :following
  end 
  end

  resources :users
  resources :relationships, only: [:create, :destroy]
      # devise_for :users, controllers: {
      #   sessions: 'users/sessions'
      # }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

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
