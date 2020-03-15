require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @screening = options['screening']
  end

  def save()
    sql = 'INSERT INTO tickets (
    customer_id,
    film_id,
    screening
    )
    VALUES
    (
    $1, $2, $3
    )
    RETURNING *'
    values = [@customer_id, @film_id, @screening]
    ticket = SqlRunner.run(sql, values)[0]
    @id = ticket['id'].to_i()
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE tickets SET
    (
    customer_id,
    film_id,
    screening
    )
    =
    (
    $1, $2, $3
    )
    WHERE id = $4"
    values = [@customer_id, @film_id, @screening, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    data = SqlRunner.run(sql)
    return Ticket.map_items(data)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|ticket| Ticket.new(ticket)}
  end

  def total_customers_per_screening()
    sql = "SELECT * FROM tickets WHERE film_id = $1 AND screening = $2"
    values = [@film_id, @screening]
    result = SqlRunner.run(sql, values)
    count = result.map{|ticket|Ticket.new(ticket)}.length()
    return count
  end

end
