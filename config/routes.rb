Toptrumps::Application.routes.draw do
  resources :cards do
    member do
      get :iframe
      get :scrape
    end
  end
  
  match '/winner', :to => 'challenge#winner'
  match '/stage', :to => 'challenge#stage'
  match '/start', :to => 'challenge#start'
  
  root :to => 'pages#index'
end
