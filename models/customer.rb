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




end
