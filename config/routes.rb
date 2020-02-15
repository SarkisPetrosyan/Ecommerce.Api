Rails.application.routes.draw do
  resources :employees

  post 'productCategory', action: :productCategory, controller: 'categories'
  # delete 'destroyproductCategory', action: :destroyproductCategory, controller: 'categories'
  delete '/categories/destroyproductCategory' => 'categories#destroyproductCategory'

  resources :shippers
  resources :customers
  resources :suppliers
  resources :categories

  get '/swagger' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
