Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'customers/invite', to: 'customers#invite'
    end
  end
end
