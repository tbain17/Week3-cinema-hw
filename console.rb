require_relative('models/customer')
require_relative('models/ticket')
require_relative('models/film')

require('pry-byebug')

customer1 = Customer.new(
  {
    "name" => "Andrew"
    "funds" => 75.50
  }
)
customer1.save()
customer2 = Customer.new(
  {
    "name" => "Jill"
    "funds" => 34.00
  }
)
customer2.save()
customer3 = Customer.new(
  {
    "name" => "Dave"
    "funds" => 56.50
  }
)
customer3.save()

film1 = Film.new(
  {
    "title" => "B"
    "price" => 7.50
  }
)
film1.save()
film2 = Film.new(
  {
    "title" => "The Potato Diaries"
    "price" => 7.50
  }
)
film2.save()
film3 = Film.new(
  {
    "title" => "The Deliciousness of Cheese"
    "price" => 7.50
  }
)
film3.save()

ticket1 = Ticket.new(
  {
    "customer_id" => customer1
    "film_id" => film2
  }
)
ticket1.save()

ticket2 = Ticket.new(
  {
    "customer_id" => customer1
    "film_id" => film1
  }
)
ticket2.save()

ticket3 = Ticket.new(
  {
    "customer_id" => customer3
    "film_id" => film2
  }
)
ticket3.save()

ticket4 = Ticket.new(
  {
    "customer_id" => customer2
    "film_id" => film3
  }
)
ticket4.save()





binding.pry
nil
