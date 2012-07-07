Toptrumps::Application.routes.draw do
  resources :cards
  
  root :to => 'pages#index'
end
