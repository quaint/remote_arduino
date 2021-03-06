Remote::Application.routes.draw do

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end

  match 'boards/:id/assign' => 'boards#assign', :as => :assign_board, :via => :get
  match 'boards/:id/assign' => 'boards#port', :as => :port_board, :via => :post
  match 'boards/sync/:serial' => 'boards#sync', :as => :sync_board, :via => :get
  match 'devices/:id/toggle' => 'devices#toggle', :as => :toggle_device, :via => :post
  match 'readings/upload' => 'readings#upload', :as => :upload_reading, :via => :post
  match 'readings/filter/serial/:serial' => 'readings#filter_by_serial', :as => :filter_serial_readings, :via => :get
  match 'readings/filter/from/:startdate/to/:enddate' => 'readings#filter_by_date', :as => :filter_date_readings, :via => :get

  resources :users
  resources :boards
  resources :devices
  resources :sensors
  resources :readings


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
  # root :to => "welcome#index"
  root :to => 'devices#index', :as => 'main'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
