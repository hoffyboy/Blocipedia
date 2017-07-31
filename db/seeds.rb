# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 3.times do
#   User.create!(
#     email: Faker::Internet.email,
#     password: 'helloworld'
#   )
# end

standard = User.create!(
  email: 'standard@example.com',
  password: '123456'
)

premium = User.create!(
  email: 'premium@example.com',
  password: '123456',
  role: 'premium'
)

upgrading = User.create!(
  email: 'upgrading@example.com',
  password: '123456',
  role: 'upgrading'
)

admin = User.create!(
  email:    'admin@example.com',
  password: '123456',
  role: 'admin'
)

50.times do
  wiki = Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(10..30) + "\n\n" + Faker::Markdown.random + "\n\n" + Faker::Lorem.paragraph(10..30) + "\n\n" + Faker::Markdown.random + "\n\n" + Faker::Lorem.paragraph(10..20),
    private: [false, true, false].sample,
    user: User.all.sample
  )
  wiki.update_attribute(:created_at, rand(5.minutes .. 1.week).ago)
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
