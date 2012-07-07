Toptrumps::Application.routes.draw do
  resources :cards do
    member do
      get :iframe
      get :scrape
    end
  end
  
  root :to => 'pages#index'
end
