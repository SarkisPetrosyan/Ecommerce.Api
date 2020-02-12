Rails.application.routes.draw do
  resources :employees
  resources :shippers
  resources :customers
  resources :suppliers
  resources :categories

  get '/swagger' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
