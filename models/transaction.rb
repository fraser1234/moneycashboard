require_relative('../db/sql_runner.rb')
require_relative('./merchant.rb')
require_relative('./tag.rb')

class Transaction

  attr_reader :id, :merchant_id, :tag_id, :price, :transaction_date

  def initialize(options)
    @id = options['id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
    @price = options['price']
    @transaction_date = options['transaction_date']
  end


  def save()
    sql = "INSERT INTO transactions
    (
      merchant_id,
      tag_id,
      price,
      transaction_date
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *"
    values = [@merchant_id, @tag_id, @price, @transaction_date]
    transaction_data = SqlRunner.run(sql, values)
    @id = transaction_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
    SET
    (
      merchant_id,
      tag_id,
      price,
      transaction_date
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@merchant_id, @tag_id, @price, @transaction_date, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    values = []
    transactions = SqlRunner.run( sql, values )
    result = transactions.map { |transaction| Transaction.new( transaction ) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run( sql, values )
    result = Transaction.new( transaction.first )
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM transactions "
    values = []
    SqlRunner.run( sql, values )
  end

  def tag
    sql = "SELECT tags.*
    FROM tags
    INNER JOIN transactions
    ON tags.id = transactions.tag_id
    WHERE transactions.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return Tag.new(result)
  end

  def merchant
    sql = "SELECT merchants.*
    FROM merchants
    INNER JOIN transactions
    ON merchants.id = transactions.tag_id
    WHERE transactions.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return Merchant.new(result)
  end

end
