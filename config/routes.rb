Canvas::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'user/token' => 'user#create_token'
  get 'users'     => 'user#index'
  get 'user/:user_token/ban' => 'user#ban'
  get 'user/:user_token/unban' => 'user#unban'

  get 'login'     => 'sessions#new'

  post 'user/verify_user' => 'user#verify_user'

  get 'flags' => 'flag#get_flags'

  get  'comments' => 'comment#index'
  post 'comment' => 'comment#create_comment'
  post '/comment/:id/downvote' => 'comment#downvote_comment'
  post '/comment/:id/upvote'   => 'comment#upvote_comment'
  post '/comment/:id/flag'     => 'comment#flag_comment'

  

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  #
  resources :sessions
  resources :sites

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
