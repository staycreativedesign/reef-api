7.times do
  Store.create(name: Faker::Restaurant.name, description: Faker::Restaurant.description, address: Faker::Address.full_address)
end

32.times do
  Item.create(store_id: rand(1..Store.count), name: Faker::Food.dish, description: Faker::Food.description, price_cents: 613)
end

50.times do
  Ingredient.create(item_id: rand(1..Item.count), name: Faker::Food.ingredient, quantity: rand(1..8))
end
