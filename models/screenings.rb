require 'pry-byebug'
require_relative '../db/sql_runner'

class Screenings

  attr_accessor :show_time1, :show_time2, :show_time3, :show_time4

  def initialize(options)
    @id = options['id']
    @film_id = options['film_id']
    @show_time1 = options['show_time1']
    @show_time2 = options['show_time2']
    @show_time3 = options['show_time3']
    @show_time4 = options['show_time4']
  end

  def save
    sql = "INSERT INTO screenings (film_id, show_time1, show_time2, show_time3, show_time4) VALUES (#{@film_id}, '#{@show_time1}', '#{@show_time2}', '#{@show_time3}', '#{@show_time4}') RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE screenings SET film_id = #{@film_id}, show_time1 = '#{@show_time1}', show_time2 = '#{@show_time2}', show_time3 = '#{@show_time3}', show_time4 = '#{@show_time4}' WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  # def delete
  #   sql = "DELETE FROM screenings WHERE id = #{@id};"
  #   SqlRunner.run(sql)
  # end

  ###

  def self.delete_all
    sql = "DELETE from screenings;"
    SqlRunner.run(sql)
  end

end