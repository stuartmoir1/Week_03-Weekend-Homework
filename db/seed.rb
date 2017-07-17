require 'pry-byebug'
require_relative '../models/customer.rb'
require_relative '../models/film.rb'
require_relative '../models/ticket.rb'
require_relative '../models/screenings.rb'

Screenings.delete_all 
Ticket.delete_all
Customer.delete_all
Film.delete_all

# Setup customers.
customer1 = Customer.new({
  'name' => 'Stuart',
  'funds' => 30,
  'tickets_bought'=> 0
})
customer2 = Customer.new({
  'name' => 'Alex',
  'funds' => 120,
  'tickets_bought'=> 0
})
customer3 = Customer.new({
  'name' => 'Dorothy',
  'funds' => 60,
  'tickets_bought'=> 0
})
customer1.save
customer2.save
customer3.save
Customer.all

# Setup films.
film1 = Film.new({
  'title' => 'Baby Driver',
  'price' => 10,
  'max_tickets' => 4,
  'tickets_sold' => 0
})
film2 = Film.new({
  'title' => 'Despicable Me 3',
  'price' => 20,
  'max_tickets' => 2,
  'tickets_sold' => 0
})
film3 = Film.new({
  'title' => 'War For The Planet Of The Apes',
  'price' => 30,
  'max_tickets' => 3,
  'tickets_sold' => 0
})
film1.save
film2.save
film3.save
Film.all

# Screenings
screenings_film1 = Screenings.new({
  'film_id' => film1.id,
  'show_time1' => '12:00',
  'show_time2' => '15:30',
  'show_time3' => '18:00',
  'show_time4' => '21:30'
})
screenings_film2 = Screenings.new({
  'film_id' => film2.id,
  'show_time1' => '12:30',
  'show_time2' => '15:00',
  'show_time3' => '17:30',
  'show_time4' => ''
})
screenings_film3 = Screenings.new({
  'film_id' => film3.id,
  'show_time1' => '14:15',
  'show_time2' => '16:00',
  'show_time3' => '18:30',
  'show_time4' => '22:00'
})
screenings_film1.save
screenings_film2.save
screenings_film3.save

# Buy tickets.
customer1.buy_ticket(film1, screenings_film1.show_time1)
customer1.buy_ticket(film1, screenings_film1.show_time2)
customer1.buy_ticket(film1, screenings_film1.show_time2)
# Insufficient funds to buy next ticket.
customer1.buy_ticket(film1, screenings_film1.show_time2)

customer2.buy_ticket(film2, screenings_film2.show_time3)
customer2.buy_ticket(film2, screenings_film2.show_time3)
# Max tickets (2) for film2 reached.
customer2.buy_ticket(film2, screenings_film2.show_time4)
customer2.buy_ticket(film3, screenings_film3.show_time4)

customer3.buy_ticket(film3, screenings_film3.show_time2)
customer3.buy_ticket(film3, screenings_film3.show_time2)
# Insufficient funds to buy next ticket; Max tickets (2) for film2 reached.
customer3.buy_ticket(film3, screenings_film3.show_time3)

Ticket.all

# Customers per film.
film1.customers.to_a.count
film2.customers.to_a.count
film3.customers.to_a.count

# Using pry, the tickets_by_show_time works - a array of show time/ ticket 
# number hashes is returned. But I get a RuntimeError when I integorate the 
# the method in pry or seed.db. The error is - You want to finish 4 frames, 
# but stack size is only 1.
film1.tickets_by_show_time(screenings_film1)
film2.tickets_by_show_time(screenings_film2)
film3.tickets_by_show_time(screenings_film3)

# Update customer.
customer1.name = 'Lindsay'
customer1.funds = 20
customer1.tickets_bought = 3
customer1.update

# Update film.
film1.title = 'Cars 3'
film1.price = 20
film1.max_tickets = 20
film1.tickets_sold = 10
film1.update

# Update screening.
screenings_film1.show_time1 = '09:00'
screenings_film1.show_time2 = '10:15'
screenings_film1.show_time3 = '11:30'
screenings_film1.show_time4 = '13:00'
screenings_film1.update

# Delete (delete all rows from screening and ticket tables due to relations).
Screenings.delete_all
Ticket.delete_all
film1.delete
customer1.delete

binding.pry
nil