Rails.application.routes.draw do
 
  root 'welcome#index', as: :home

  post '/' => 'users#login'

  get 'users/home' => 'users#home', as: :userhome

  get 'hey/logout'  => 'users#logout', as: :logout  

  get 'website/add' => 'users#websiteRegistration',as: :webadd

  post 'website/add' => 'users#websiteRegistration'

  get 'users/registration' => 'users#userRegistration',as: :userReg

  post 'users/registration' => 'users#saveUser'

  get 'users/account/deactivate'  =>'users#removeUser',as: :deactivate

  post 'users/account/deactivate' => 'users#removeUser'

  get 'tracker/log' => 'tracker#log'

  get 'analytics/perDay/:tracking_id' => 'analytics#perDay'

  get 'analytics/perMonth/:tracking_id' => 'analytics#perMonth'
 
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
