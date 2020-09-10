# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 20.times do
#     Supplier.create(
#      supplierName: Faker::Name.name,
#      contactName:  Faker::Name.name, 
#      address:  Faker::Address.street_address,
#      city: Faker::Address.city, 
#      postalCode: Faker::Address.postcode,
#      country: Faker::Address.country,
#      phone: '098989898'
#     )
# end
# 20.times do
#         Shipper.create(
#          shipperName: Faker::Name.name,
#           phone: Faker::Number.number(digits: 10)
#         )
#     end
20.times do
    cat = Category.create(categoryName: Faker::Food.dish, description:  Faker::Food.description)
    product = Product.create(productName: Faker::Food.dish, unit: '1kg', price: 200, supplier_id: 1)
    prcat = ProductCategory.create(product: product, category: cat)          
end

# 20.times do
#         Employee.create(
#          lastName: Faker::Name.name,
#          firstName:  Faker::Name.name, 
#          birthDay:  Faker::Date.birthday(min_age: 18, max_age: 65),
#          photo: Faker::Avatar.image, 
#          notes: Faker::Food.description
#         )
#     end
# 20.times do
#     Customer.create(
#         customerName: Faker::Name.name,
#          contactName:  Faker::Name.name, 
#          address:  Faker::Address.street_address,
#          city: Faker::Address.city, 
#          postalCode: Faker::Address.postcode,
#          country: Faker::Address.country,
#          )
#     end

# 20.times do
#         Order.create(
#             orderDate: Faker::Date.birthday(min_age: 18, max_age: 65),
#             customer_id:  Faker::Number.within(range: 1..20),
#             employee_id:  Faker::Number.within(range: 1..20),
#             shipper_id: Faker::Number.within(range: 1..20) 
#              )
#         end
# 20.times do
#     OrderDetail.create(
#         quantity: Faker::Number.within(range: 5..100),
#         order_id:  Faker::Number.within(range: 1..20),
#         product_id:  Faker::Number.within(range: 1..20),
            
#              )
#         end



