# This file should contain all the record creation needed,
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'activerecord-reset-pk-sequence'

Favorite.destroy_all
Favorite.reset_pk_sequence
Image.destroy_all
Image.reset_pk_sequence
Rank.destroy_all
Rank.reset_pk_sequence
Order.destroy_all
Order.reset_pk_sequence
Package.destroy_all
Package.reset_pk_sequence
Tag.destroy_all
Tag.reset_pk_sequence
JoinGameAndTag.destroy_all
JoinGameAndTag.reset_pk_sequence
Rent.destroy_all
Rent.reset_pk_sequence
Comment.destroy_all
Comment.reset_pk_sequence
Cart.destroy_all
Cart.reset_pk_sequence
Game.destroy_all
Game.reset_pk_sequence
User.destroy_all
User.reset_pk_sequence


25.times do
    Game.create(
        name: Faker::Game.title,
        price: rand(5..100),
        creator: Faker::Name.name,
        editor: Faker::TvShows::Stargate.planet,
        description: Faker::Lorem.question(word_count: 24),
        min_player: rand(1..4),
        max_player: rand(4..20),
        min_age: rand(4..18),
        release_date: Faker::Date.in_date_period(year: rand(1995..2021)),
        sell_stock: rand(1..20),
        rent_stock: rand(1..20)
        )
    puts 'Game crée'
end

Package.create(
    game_number:1,
    name:"Débutant",
    price: 1000,
    price_id: "price_1K81GJDzWhv05aHOkJbQ12dn",
    description: "Location d'un jeu maximum simultanément / mois.\n
     Vous pouvez préparer les jeux pour le mois suivant en les ajoutant à votre Liste de Souhaits.\n
     A partir du 1er du mois suivant, vos jeux placés dans votre Liste de Souhaits seront livrés et il vous sera demandé de nous retourner les votres!"
    )
puts 'Package crée'

Package.create(
    game_number:2,
    name:"Habitué",
    price: 1500,
    price_id: "price_1K81H5DzWhv05aHOWgjjlK5J",
    description: "Location de 2 jeux maximum simultanément / mois.\n
    Vous pouvez préparer les jeux pour le mois suivant en les ajoutant à votre Liste de Souhaits.\n
    A partir du 1er du mois suivant, vos jeux placés dans votre Liste de Souhaits seront livrés et il vous sera demandé de nous retourner les votres!"
    )
puts 'Package crée'

Package.create(
    game_number:4,
    name:"Expert",
    price: 2000,
    price_id: "price_1K81HkDzWhv05aHOWYRysKOG",
    description: "Location de 4 jeux maximum simultanément / mois.\n
    Vous pouvez préparer les jeux pour le mois suivant en les ajoutant à votre Liste de Souhaits.\n
    A partir du 1er du mois suivant, vos jeux placés dans votre Liste de Souhaits seront livrés et il vous sera demandé de nous retourner les votres!"
    )
puts 'Package crée'

["Stratégie", "Plateau", "Coopération", "Hasard", "Carte", "Culturel", "Enfant", "Adulte", "Dextérité", "Reflexion"].each do |tag|
    Tag.create(
        name: tag
        )
    puts 'Tag crée'
end

10.times do 
    JoinGameAndTag.create(
        game_id: rand(1..25),
        tag_id: rand(1..10)
        )
    puts 'JoinGameAndTag crée'
end

User.create(
    first_name: Faker::Internet.username ,
    last_name: Faker::Internet.username,
    email: "admin@playbox.thp",
    password:"123456",
    address:((rand(200)).to_s + " grande rue " + (Faker::Address.zip).to_s + " " + (Faker::Address.city) ),
    phone: "0" + rand(100000000..999999999).to_s,
    admin: true,
    package_id: 1
    )
puts "Admin crée"

5.times do
    User.create(
        first_name: Faker::Internet.username ,
        last_name: Faker::Internet.username,
        email: Faker::Internet.email,
        password: "123456",
        address: ((rand(200)).to_s + " grande rue " + (Faker::Address.zip).to_s + " " + (Faker::Address.city) ),
        phone: "0" + rand(100000000..999999999).to_s,
        admin: false,
        package_id:1
        )
    puts 'User crée'
end

5.times do 
    Rent.create(
        game_id: rand(1..25),
        user_id: rand(1..6),
        quantity: rand(1..3),
        status: 1
    )
    puts 'Rent crée'
end

10.times do 
    Rank.create(
        game_id: rand(1..25),
        user_id: rand(1..6),
        note: rand(1..5),
    )
    puts 'Rank crée'
end

15.times do 
    Comment.create(
        game_id: rand(1..25),
        user_id: rand(1..6),
        content: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
    )
    puts 'Comment crée'
end

5.times do 
    Favorite.create(
        game_id: rand(1..25),
        user_id: rand(1..6),
    )
    puts 'Favorite crée'
end

=begin
 10.times do 
    Cart.create(
        user_id: rand(1..6),
        paid: [true, false].sample,
        stripe_customer_id: rand(100000..999999).to_s
    )
    puts 'Cart crée'
end 
=end

10.times do 
    Order.create(
        game_id: rand(1..25),
        cart_id: rand(1..10),
        quantity: rand(1..3)
    )
    puts 'Order crée'
end

80.times do
    Image.create(
        game_id: rand(1..25),
        public_id: "seed/game_"+rand(1..50).to_s
    )
    puts 'Image créee'
end