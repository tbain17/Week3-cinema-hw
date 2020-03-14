require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @screening1 = options['screening1']
    @screening2 = options['screening2']
    @screening3 = options['screening3']
  end

  def save()
    sql = "INSERT INTO screenings (
    title,
    screening1,
    screening2,
    screening3
    )
    values
    (
    $1, $2, $3, $4
    )
    RETURNING *"
    values = [@title, @screening1, @screening2, @screening3]
    screenings = SqlRunner.run(sql, values)[0]
    @id = screenings['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end
