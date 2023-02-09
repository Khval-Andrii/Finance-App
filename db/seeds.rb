# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

categories = Category.pluck(:id)

100.times do 
  Operation.create(
    amount: Faker::Commerce.price,
    odate: Faker::Date.between(from: "2022-08-01", to: "2023-03-01"),
    description: Faker::Lorem.sentence,
    category_id: Faker::Number.sample(categories),
    types: Faker::Number.within(range: 1..2)
  )
end



