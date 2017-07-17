require_relative '../db/sql_runner'

class Ticket

  attr_reader :show_time

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id']
    @show_time = options['show_time']
  end

  def save
    sql = "INSERT INTO tickets (customer_id, film_id, show_time) VALUES (#{@customer_id}, #{@film_id}, '#{@show_time}') RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  # def delete
  #   sql = "DELETE FROM tickets WHERE id = #{@id};"
  #   SqlRunner.run(sql)
  # end

  ###

  def self.all
    sql = "SELECT * from tickets;"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE from tickets;"
    SqlRunner.run(sql)
  end

end