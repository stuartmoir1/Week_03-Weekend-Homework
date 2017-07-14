require_relative '../db/sql_runner'

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE films SET title = '#{@title}', price = #{@price} WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM films WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  ###

  def self.all
    sql = "SELECT * from films;"
    SqlRunner.run(sql)
  end

end