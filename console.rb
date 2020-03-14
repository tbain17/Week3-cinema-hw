require_relative('models/customer')
require_relative('models/ticket')
require_relative('models/film')
require_relative('models/screening')

require('pry-byebug')

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()



customer1 = Customer.new(
  {
    "name" => "Andrew",
    "funds" => 75
  }
)
customer1.save()
customer2 = Customer.new(
  {
    "name" => "Jill",
    "funds" => 34
  }
)
customer2.save()
customer3 = Customer.new(
  {
    "name" => "Dave",
    "funds" => 56
  }
)
customer3.save()
customer4 = Customer.new(
  {
    "name" => "Jimmy",
    "funds" => 10
  }
)
customer4.save()
customer5 = Customer.new(
  {
    "name" => "Lola",
    "funds" => 89
  }
)
customer5.save()

film1 = Film.new(
  {
    "title" => "B",
    "price" => 7
  }
)
film1.save()
film2 = Film.new(
  {
    "title" => "The Potato Diaries",
    "price" => 4
  }
)
film2.save()
film3 = Film.new(
  {
    "title" => "The Deliciousness of Cheese",
    "price" => 12
  }
)
film3.save()

screening_film_1 = Screening.new(
  {
    "film_id" => film1.id,
    "screening1" => "1030",
    "screening2" => "1430",
    "screening3" => "1900"
  }
)
screening_film_1.save()

screening_film_2 = Screening.new(
  {
    "film_id" => film2.id,
    "screening1" => "1000",
    "screening2" => "1730",
    "screening3" => "2200"
  }
)
screening_film_2.save()

screening_film_3 = Screening.new(
  {
    "film_id" => film3.id,
    "screening1" => "1230",
    "screening2" => "1530",
    "screening3" => "2000"
  }
)
screening_film_3.save()

ticket1 = Ticket.new(
  {
    "customer_id" => customer1.id,
    "film_id" => film2.id,
    "screening" => screening_film_2.screening1
  }
)
ticket1.save()

ticket2 = Ticket.new(
  {
    "customer_id" => customer1.id,
    "film_id" => film1.id,
    "screening" => screening_film_1.screening2
  }
)
ticket2.save()

ticket3 = Ticket.new(
  {
    "customer_id" => customer3.id,
    "film_id" => film2.id,
    "screening" => screening_film_2.screening2
  }
)
ticket3.save()

ticket4 = Ticket.new(
  {
    "customer_id" => customer2.id,
    "film_id" => film3.id,
    "screening" => screening_film_3.screening3
  }
)
ticket4.save()

ticket5 = Ticket.new(
  {
    "customer_id" => customer2.id,
    "film_id" => film1.id,
    "screening" => screening_film_1.screening3
  }
)
ticket5.save()

ticket6 = Ticket.new(
  {
    "customer_id" => customer1.id,
    "film_id" => film3.id,
    "screening" => screening_film_3.screening1
  }
)
ticket6.save()

ticket7 = Ticket.new(
  {
    "customer_id" => customer3.id,
    "film_id" => film3.id,
    "screening" => screening_film_3.screening3
  }
)
ticket7.save()

ticket8 = Ticket.new(
  {
    "customer_id" => customer4.id,
    "film_id" => film3.id,
    "screening" => screening_film_3.screening3
  }
)
ticket8.save()
ticket9 = Ticket.new(
  {
    "customer_id" => customer5.id,
    "film_id" => film3.id,
    "screening" => screening_film_3.screening3
  }
)
ticket9.save()
ticket9 = Ticket.new(
  {
    "customer_id" => customer2.id,
    "film_id" => film3.id,
    "screening" => screening_film_3.screening3
  }
)
ticket9.save()








binding.pry
nil
