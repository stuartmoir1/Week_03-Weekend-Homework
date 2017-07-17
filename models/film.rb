require 'pry-byebug'
require_relative '../db/sql_runner'

class Film

  attr_reader :id
  attr_accessor :title, :price, :max_tickets, :tickets_sold

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
    @max_tickets = options['max_tickets'].to_i
    @tickets_sold = options['tickets_sold'].to_i
  end

  def save
    sql = "INSERT INTO films (title, price, max_tickets, tickets_sold) VALUES ('#{@title}', #{@price}, #{@max_tickets}, #{@tickets_sold}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE films SET title = '#{@title}', price = #{@price}, tickets_sold = #{@tickets_sold}, max_tickets = #{@max_tickets} WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM films WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = #{@id};"
    SqlRunner.run(sql)
  end

  def tickets_by_show_time(screenings)
    sql = "SELECT * FROM tickets WHERE film_id = #{@id};"
    tickets = SqlRunner.run(sql)
    
    show_time1_tickets = tickets.map.count { |tickets| tickets['show_time'] == screenings.show_time1}
    show_time2_tickets = tickets.map.count { |tickets| tickets['show_time'] == screenings.show_time2}
    show_time3_tickets = tickets.map.count { |tickets| tickets['show_time'] == screenings.show_time3}
    show_time4_tickets = tickets.map.count { |tickets| tickets['show_time'] == screenings.show_time4}

    tickets_ary = [
      { show_time: screenings.show_time1, tickets: show_time1_tickets},
      { show_time: screenings.show_time2, tickets: show_time2_tickets},
      { show_time: screenings.show_time3, tickets: show_time3_tickets},
      { show_time: screenings.show_time4, tickets: show_time4_tickets}
    ]
    sorted_tickets_ary = tickets_ary.sort_by { |x| x[:tickets] }
    sorted_tickets_ary.reverse
  end

  ###

  def self.all
    sql = "SELECT * from films;"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE from films;"
    SqlRunner.run(sql)
  end

end