require_relative '../db/sql_runner'

class Ticket

  def initialize(options)
    @id = options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{@film_id}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  ###

  def self.all
    sql = "SELECT * from tickets;"
    SqlRunner.run(sql)
  end

end