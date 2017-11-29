require_relative('../db/sql_runner.rb')
require_relative('transaction.rb')

class Tag

  attr_reader :id
  attr_accessor :tag_name

  def initialize(options)
    @id = options['id'].to_i
    @tag_name = options['tag_name']
  end

  def save()
    sql = "INSERT INTO tags
    (
      tag_name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@tag_name]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE tags
    SET
    (
      tag_name
    ) =
    (
      $1
    )
    WHERE id = $2"
    values = [@tag_name, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM tags"
    values = []
    tags = SqlRunner.run( sql, values )
    result = tags.map { |tag| Tag.new( tag ) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    tag = SqlRunner.run( sql, values )
    result = Tag.new( tag.first )
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tags "
    values = []
    SqlRunner.run( sql, values )
  end

  def self.total_spend_tag(id)
    sql = "SELECT SUM (price)
    FROM transactions
    WHERE tag_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result [0]['sum']
  end
end
