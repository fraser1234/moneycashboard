require_relative('../db/sql_runner.rb')
require_relative('./transaction.rb')

class Merchant

  attr_reader :id, :merchant

  def initialize(options)
    @id = options['options'].to_i
    @merchant = options['merchant']
  end

  def save()
    sql = "INSERT INTO merchants
    (
      merchant
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@merchant]
    merchant_data = SqlRunner.run(sql, values)
    @id = merchant_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE merchants
    SET
    (
      merchant
    ) =
    (
      $1
    )
    WHERE id = $5"
    values = [@merchant, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM tags"
    values = []
    merchants = SqlRunner.run( sql, values )
    result = merchants.map { |merchant| Merchant.new( merchant ) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [id]
    merchant = SqlRunner.run( sql, values )
    result = Merchant.new( merchant.first )
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM merchants "
    values = []
    SqlRunner.run( sql, values )
  end

end
