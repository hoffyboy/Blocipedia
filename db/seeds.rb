# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'helloworld'
  )
end

standard = User.create!(
  email: 'standard@example.com',
  password: 'helloworld'
)

premium = User.create!(
  email: 'premium@example.com',
  password: 'helloworld',
  role: 'premium'
)

admin = User.create!(
  email:    'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(10..80),
    private: [false, true, false].sample,
    user: User.all.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
