Rails.application.routes.draw do


  post 'customer_token' => 'customer_token#create'

  resources :employees

  post 'productCategory', action: :productCategory, controller: 'product_category'
  get 'CategoryProdAll', action: :CategoryProdAll, controller: 'product_category'
  get 'CategoryPro', action: :CategoryPro, controller: 'product_category'
  post 'CategoryProd' => 'product_category#CategoryProd'

  # post 'getAllOrderDatilsCustomers', action: :getAllOrderDatilsCustomers, controller: 'customers'
  # delete 'destroyproductCategory', action: :destroyproductCategory, controller: 'categories'
  delete '/product_category/destroyproductCategory' => 'product_category#destroyproductCategory'
  # get '/product_category/CategoryProdAll' => 'product_category#CategoryProdAll'
  post 'getAllOrderDatilsCust' => 'customers#getAllOrderDatilsCust'
  get 'current' => 'customers#current'
  get 'GetProductCategory/:id' => 'product_category#GetProductCategory'
  get 'searchProduct/:search' => 'products#searchProduct'

  resources :shippers
  resources :customers
  resources :suppliers
  resources :categories
  resources :products

  # shopping_carts
  get 'cart' => 'shopping_carts#index'
  post 'new_cart' => 'shopping_carts#create'

  get '/swagger' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
