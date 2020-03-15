require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @price = options['price'].to_i()
  end

  def save()
    sql = 'INSERT INTO films (
    title,
    price
    )
    VALUES
    (
    $1, $2
    )
    RETURNING *'
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0]
    @id = film['id'].to_i()
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET
    (
    title,
    price
    )
    =
    (
    $1, $2
    )
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    data = SqlRunner.run(sql)
    return Film.map_items(data)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|film| Film.new(film)}
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return Customer.map_items(customer_data)
  end

  def count_customers()
    total_customers = self.customers()
    return total_customers.length()
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE film_id = $1"
    values = [@id]
    all_tickets = SqlRunner.run(sql, values)
    return all_tickets.map{|ticket| Ticket.new(ticket)}
  end

  def self.screenings()
    sql = "SELECT * FROM screenings"
    all_screenings = SqlRunner.run(sql).map{|screening| Screening.new(screening)}
    return all_screenings
  end

  def screenings()
    sql = "SELECT * FROM screenings where film_id = $1"
    values = [@id]
    all_screenings = SqlRunner.run(sql, values).map{|screening| Screening.new(screening)}
    return all_screenings
  end

  def popular_screening()
    sql = "SELECT screening FROM tickets WHERE film_id = $1 GROUP BY screening ORDER BY COUNT(*) DESC LIMIT 1"
    values = [@id]
    screening = SqlRunner.run(sql, values).map{|screening| Ticket.new(screening)}
    return screening[0].screening
  end

end
