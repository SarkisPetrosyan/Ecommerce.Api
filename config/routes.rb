Rails.application.routes.draw do
  post 'customers_token' => 'customers_token#create'
  post 'user_token' => 'user_token#create'
  resources :employees

  post 'productCategory', action: :productCategory, controller: 'product_category'
  post 'CategoryProd', action: :CategoryProd, controller: 'product_category'
  get 'CategoryPro', action: :CategoryPro, controller: 'product_category'
  # delete 'destroyproductCategory', action: :destroyproductCategory, controller: 'categories'
  delete '/product_category/destroyproductCategory' => 'product_category#destroyproductCategory'

  resources :shippers
  resources :customers
  resources :suppliers
  resources :categories

  get '/swagger' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
