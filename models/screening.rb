require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening1, :screening2, :screening3

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @film_id = options['film_id']
    @screening1 = options['screening1']
    @screening2 = options['screening2']
    @screening3 = options['screening3']
  end

  def save()
    sql = "INSERT INTO screenings (
    film_id,
    screening1,
    screening2,
    screening3
    )
    values
    (
    $1, $2, $3, $4
    )
    RETURNING *"
    values = [@film_id, @screening1, @screening2, @screening3]
    screenings = SqlRunner.run(sql, values)[0]
    @id = screenings['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end





  # def films()
  #   sql = "SELECT * FROM films WHERE films.id = $1"
  #   values = [$film_id]
  #   all_screenings = SqlRunner.run(sql,values)
  #   return all_screenings.map{|screening| Screening.new(screening)}
  # end


  # def film_screening_times()
  #   sql = "SELECT films.title,screenings.screening1, screenings.screening2, screenings.screening3 FROM films INNER JOIN screenings on films.id = screenings.film_id WHERE screenings.film_id = $1"
  #   values = [@film_id]
  #   return SqlRunner.run(sql)
    #
    # def self.screening_times()
    #   sql = "SELECT films.title,screenings.screening1, screenings.screening2, screenings.screening3 FROM films INNER JOIN screenings on films.id = screenings.film_id"
    #   return SqlRunner.run(sql).map{|screening|Screening.new(screening)}
    # end

  # end


end
