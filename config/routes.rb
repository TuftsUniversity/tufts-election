# frozen_string_literal: true
ALLOW_DOTS ||= /[a-zA-Z0-9_\-.:]*/

TuftsElection::Application.routes.draw do
  concern :searchable, Blacklight::Routes::Searchable.new

  concern :range_searchable, BlacklightRangeLimit::Routes::RangeSearchable.new
  mount Riiif::Engine => '/page_images', as: 'riiif'

  mount Qa::Engine => '/qa'

  mount Blacklight::Engine => '/'

  root to: "catalog#index"

  concern :exportable, Blacklight::Routes::Exportable.new
  resources :solr_documents, id: ALLOW_DOTS, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  concern :searchable, Blacklight::Routes::Searchable.new
  resource :catalog, id: ALLOW_DOTS, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
    concerns :range_searchable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  match '/catalog/:id/track', to: 'catalog#track', id: ALLOW_DOTS, via: [:get, :post], as: 'catalog' do
    concerns :searchable
  end
  match '/candidates/:id/track', to: 'candidates#track', id: ALLOW_DOTS, via: [:get, :post], as: 'track_candidates' do
    concerns :searchable
  end
  resources :candidates, only: [:index] do
    concerns :searchable
  end

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
