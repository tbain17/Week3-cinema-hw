require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds'].to_i()
  end

  def save()
    sql = 'INSERT INTO customers (
    name,
    funds
    )
    VALUES
    (
    $1, $2
    )
    RETURNING *'
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i()
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET
    (
    name,
    funds
    )
    =
    (
    $1, $2
    )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    data = SqlRunner.run(sql)
    return Customer.map_items(data)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|customer| Customer.new(customer)}
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON film.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return Film.map_items(film_data)
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE tickets.customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.map{|ticket| Tickets.new(ticket)}
  end

  def buy_ticket()
    tickets = self.tickets()
    ticket_prices = tickets.map{|ticket| ticket.price}
    total_ticket_cost = ticket_prices.sum
    return @funds - total_ticket_cost
  end

  def count_tickets()
    tickets = self.tickets()
    return tickets.length()
  end

end
