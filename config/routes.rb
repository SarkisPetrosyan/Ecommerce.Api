Rails.application.routes.draw do

  post 'customer_token' => 'customer_token#create'
  post 'user_token' => 'user_token#create'

  resources :employees

  post 'productCategory', action: :productCategory, controller: 'product_category'
  post 'CategoryProd', action: :CategoryProd, controller: 'product_category'
  get 'CategoryProdAll', action: :CategoryProdAll, controller: 'product_category'
  get 'CategoryPro', action: :CategoryPro, controller: 'product_category'

  # post 'getAllOrderDatilsCustomers', action: :getAllOrderDatilsCustomers, controller: 'customers'
  # delete 'destroyproductCategory', action: :destroyproductCategory, controller: 'categories'
  delete '/product_category/destroyproductCategory' => 'product_category#destroyproductCategory'
  # get '/product_category/CategoryProdAll' => 'product_category#CategoryProdAll'
  post 'getAllOrderDatilsCust' => 'customers#getAllOrderDatilsCust'

  resources :shippers
  resources :customers
  resources :suppliers
  resources :categories

  get '/swagger' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
