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
    return data.map{|film|Film.new(film)}
  end

end
