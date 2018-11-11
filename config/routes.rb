Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    wash_out :clients

  # ClientsController::Application.routes.draw do
  #   wash_out :clients
  # end

  # HelloWorld::Application.routes.draw do
  #   wash_out :api
  # end

end
