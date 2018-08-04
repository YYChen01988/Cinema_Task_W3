require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (title, price)
    VALUES($1, $2)
    RETURNING id"
    values = [@title, @price]
    location = SqlRunner.run( sql, values ).first
    @id = location['id'].to_i
  end

  def update()
    sql = "
    UPDATE films SET (
      title,
      price
      ) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new( film ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map{|customer| Customer.new(customer)}
  end

  def customer_count()
    sql = "SELECT COUNT(DISTINCT(tickets.customer_id)) FROM tickets WHERE film_id = $1"
    values = [@id]
    customer_count = SqlRunner.run(sql, values)[0]
    return customer_count['count'].to_i
  end


end
