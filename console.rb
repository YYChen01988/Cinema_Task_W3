require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/screening' )
require_relative( 'models/ticket' )



require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()
Screening.delete_all()


screening1 = Screening.new({ 'screen_time' => '10:00'})
screening1.save()
screening2 = Screening.new({ 'screen_time' => '12:00'})
screening2.save()
screening3 = Screening.new({ 'screen_time' => '14:00'})
screening3.save()




customer1 = Customer.new({ 'name' => 'April', 'wallet' => 80})
customer1.save()

customer2 = Customer.new({ 'name' => 'Ken', 'wallet' => 100})
customer2.save()

customer3 = Customer.new({ 'name' => 'Lucy', 'wallet' => 150})
customer3.save()





film1 = Film.new({ 'title' => 'Get Out', 'price' => 20})
film1.save()

film2 = Film.new({ 'title' => 'Skyscraper', 'price' => 15})
film2.save()

film3 = Film.new({ 'title' => 'Scary Movie', 'price' => 25})
film3.save()




ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id,
  'screening_id' => screening1.id
  })
ticket1.save()
customer1.fee_charge(film1.price)

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id,
  'screening_id' => screening2.id
  })
ticket2.save()
customer2.fee_charge(film2.price)


ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id,
  'screening_id' => screening3.id
  })
ticket3.save()
customer1.fee_charge(film2.price)


ticket4 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id,
  'screening_id' => screening1.id
  })
ticket4.save()
customer2.fee_charge(film1.price)


ticket5 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film3.id,
  'screening_id' => screening3.id
  })
ticket5.save()
customer2.fee_charge(film3.price)


ticket6 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film3.id,
  'screening_id' => screening1.id
  })
ticket6.save()
customer2.fee_charge(film3.price)





binding.pry
nil
