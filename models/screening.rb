require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :screen_time

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @screen_time = options['screen_time']
  end

  def save()
    sql = "INSERT INTO screenings
    (screen_time)
    VALUES($1)
    RETURNING id"
    values = [@screen_time]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end

  def popular_time()
    sql = "SELECT screen_time, COUNT(tickets.*) FROM tickets INNER JOIN screenings ON tickets.screening_id = screenings.id GROUP BY screen_time ORDER BY count DESC limit 1"
    values = []
    tickets_count = SqlRunner.run(sql, values)
    return tickets_count.first["screen_time"]
  end




end
