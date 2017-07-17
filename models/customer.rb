require 'pry-byebug'
require_relative '../db/sql_runner'

class Customer

  attr_reader :id
  attr_accessor :name, :funds, :tickets_bought

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
    @tickets_bought = options['tickets_bought']
  end

  def save
    sql = "INSERT INTO customers (name, funds, tickets_bought) VALUES ('#{@name}', #{@funds}, #{@tickets_bought}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE customers SET name = '#{@name}', funds = #{@funds}, tickets_bought = #{@tickets_bought} WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def buy_ticket(film, show_time)

    if (@funds >= film.price) && (film.max_tickets >= film.tickets_sold + 1)
      @funds -= film.price
      @tickets_bought += 1
      film.tickets_sold += 1
      update
      film.update

      ticket = Ticket.new ({
        'customer_id' => @id,
        'film_id' => film.id,
        'show_time' => show_time
      })
      ticket.save
    end

  end

  ###

  def self.all
    sql = "SELECT * from customers;"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE from customers;"
    SqlRunner.run(sql)
  end

end