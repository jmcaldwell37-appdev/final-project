# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#   Character.create(name: 'Luke', movie: movies.first)
Event.create(name: "the temperature drops below freezing")
Event.create(name: "the Bucks win a game")
Event.create(name: "ReliefWeb declares a natural disaster")
Event.create(name: "Donald Trump tweets")

AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
