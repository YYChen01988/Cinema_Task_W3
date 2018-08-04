require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :wallet

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @wallet = options['wallet'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (name,wallet)
    VALUES($1, $2)
    RETURNING id"
    values = [@name, @wallet]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def update()
    sql = "
    UPDATE customers SET (
      name,
      wallet
      ) = ($1, $2)
    WHERE id = $3"
    values = [@name, @wallet, @id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map{|film| Film.new(film)}
  end

  def fee_charge()
   sql = "SELECT SUM(films.price) FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
   values = [@id]
   price = SqlRunner.run(sql, values)[0]
   @wallet -= price['sum'].to_i
  end




end
