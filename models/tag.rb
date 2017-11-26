require_relative('../db/sql_runner.rb')
require_relative('./transaction.rb')

class Tag

  attr_reader :id, :tag

  def initialize(options)
    @id = options['options'].to_i
    @tag = options['tag']
  end

  def save()
    sql = "INSERT INTO tags
    (
      tag
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@tag]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE tags
    SET
    (
      tag
    ) =
    (
      $1
    )
    WHERE id = $5"
    values = [@tag, @id]
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

end
