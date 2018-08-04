require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({ 'name' => 'April', 'wallet' => 80})
customer1.save()

customer2 = Customer.new({ 'name' => 'Ken', 'wallet' => 100})
customer2.save()




film1 = Film.new({ 'title' => 'Get Out', 'price' => 20})
film1.save()

film2 = Film.new({ 'title' => 'Skyscraper', 'price' => 15})
film2.save()

film3 = Film.new({ 'title' => 'Scary Movie', 'price' => 25})
film3.save()




ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket4.save()

ticket5 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film3.id})
ticket5.save()




binding.pry
nil
