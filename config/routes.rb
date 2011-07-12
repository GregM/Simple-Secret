Secret::Application.routes.draw do
  get "/:code" => "contents#search"
  resources :contents do
    collection do
      get 'search'
    end
  end
  root :to => "contents#index"
end
