# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

25.times do
Game.create(name: Faker::Game.title ,  price: 100, creator:Faker::Name.name, editor:Faker::TvShows::Stargate.planet, description:Faker::Lorem.question(word_count: 24),min_player: 4,max_player:20,min_age:4,release_date:'10/02/2022',sell_stock:20,rent_stock:2)
puts 'Game crée'
end

Package.create(game_number:2,name:"Abo Rsa", price: 9.99)
puts 'Package crée'

User.create(
    first_name: Faker::Internet.username ,
    last_name: Faker::Internet.username,
    email: "admin@playbox.thp",
    password:"123456",
    address:((rand(200)).to_s + " grande rue " + (Faker::Address.zip).to_s + " " + (Faker::Address.city) ),
    phone: 10.times.map{rand(10)}.join,
    admin: true,
    subscription_ending: "2021-12-07 22:01:27.539945000 +0000",
    package_id: nil)
puts "Admin crée"

5.times do
User.create(
    first_name: Faker::Internet.username ,
    last_name: Faker::Internet.username,
    email:Faker::Internet.email,
    password:"123456",
    address:((rand(200)).to_s + " grande rue " + (Faker::Address.zip).to_s + " " + (Faker::Address.city) ),
    phone: 10.times.map{rand(10)}.join,
    admin: false,
    subscription_ending:"2021-12-07 22:01:27.539945000 +0000",
    package_id:1)
puts 'User crée'
end

30.times do
    Image.create(game_id:(rand(25)),public_id:'https://cdn.w600.comps.canstockphoto.fr/jeu-table-diamant-three-player-image_csp68281811.jpg')
    puts 'image créee'
end

