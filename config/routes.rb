Rails.application.routes.draw do
  resources :high_scores
  resources :articles do
    resources :comments
  end
  root 'welcome#index'
end
