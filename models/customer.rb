require_relative '../db/sql_runner'

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE customers SET name = '#{@name}', funds = #{@funds} WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  ###

  def self.all
    sql = "SELECT * from customers;"
    SqlRunner.run(sql)
  end

end