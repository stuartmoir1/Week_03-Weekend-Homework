require 'pry-byebug'
require_relative '../models/customer.rb'
require_relative '../models/film.rb'
require_relative '../models/ticket.rb'

# Ticket.delete_all
# Customer.delete_all
# Film.delete_all

customer1 = Customer.new({
  'name' => 'Stuart',
  'funds' => 30
})
customer1.save

film1 = Film.new({
  'title' => 'Baby Driver',
  'price' => 10
})
film1.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
})
ticket1.save

customer1.name = 'Alex'
customer1.funds = 20
customer1.update

film1.title = 'Despicable Me 3'
film1.price = 20
film1.update

# ticket1.delete
# film1.delete
# customer1.delete

binding.pry
nil