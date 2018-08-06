require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :screen_time, :screen_size

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @screen_time = options['screen_time']
    @screen_size = options['screen_size'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
    (screen_time, screen_size)
    VALUES($1, $2)
    RETURNING id"
    values = [@screen_time, @screen_size]
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

  def limited_ticket()
    sql = "SELECT COUNT(tickets.*) FROM tickets WHERE tickets.screening_id = $1"
    values = [@id]
    tickets_count = SqlRunner.run(sql, values)[0]
    if tickets_count['count'].to_i >= screen_size
      return "Sorry the tickets are sold out!"
    end
  end


end
