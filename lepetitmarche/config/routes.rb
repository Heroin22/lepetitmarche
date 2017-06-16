Rails.application.routes.draw do
  root 'ad#listAd'

  get 'annonces', :to=>'ad#listAd', :as=> :listAd

  get 'annonce', :to=>'ad#detailAd', :as=> :detailAd

  post 'annonce/getDonneesAd', :to=>'ad#getDonneesAd'

  get 'ajouter', :to=>'ad#newAd', :as=> :createAd

  get 'mes-annonce', :to=>'ad#mesAnnonce', :as=> :mesAnnonce

  post 'ajouter', :to=>'ad#createAd', :as=> :newAdAction

  get 'rechercher', :to=>'ad#findAd', :as=> :findAd

  get 'mes-annonces/modifier', :to=>'ad#modifyAd', :as=> :modifyAd

  post 'mes-annonces/update', :to=>'ad#updateAd', :as=> :UpdateAd

  get 'mes-annonces/supprimer', :to=>'ad#deleteAd', :as=> :deleteAd

  #post 'formulaire', :to=>'forms#create', :as=> :formulaireP

  post 'annonces/search' => 'ad#search'

  post 'annonces/searchWithSort' => 'ad#searchWithSort'

  post 'annonces/getVilleByDep' => 'ad#getVilleByDep'

  post 'mes-annonces/annonces/getVilleByDep' => 'ad#getVilleByDep'



  devise_for :users, :controllers => { registrations: 'users/registrations' }
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
