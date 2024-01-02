Rails.application.routes.draw do
  root 'home#index'

  resources :home, only: [:index] do
    collection do
      post :menu
    end
  end

end
