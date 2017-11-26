require('pry')
require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')


Tag.delete_all()
Merchant.delete_all()
Transaction.delete_all()

#tag
tag1 = Tag.new({
  "tag" => "Clothing"
  })
tag1.save()

tag2 = Tag.new({
  "tag" => "Hardware"
  })
tag2.save()

tag3 = Tag.new({
  "tag" => "Food"
  })
tag3.save()

tag4 = Tag.new({
  "tag" => "Drink"
  })
tag4.save()

#merchant

merchant1 = Merchant.new({
  "merchant" => "Tesco"
  })
merchant1.save()

merchant2 = Merchant.new({
  "merchant" => "Asda"
  })
merchant2.save()

merchant3 = Merchant.new({
  "merchant" => "Jewson"
  })
merchant3.save()

merchant4 = Merchant.new({
  "merchant" => "House of Fraser"
  })
merchant4.save()



transaction1 = Transaction.new({
  "merchant_id" => merchant1.id,
  "tag_id" => tag1.id,
  "price" => 20,
  "transaction_date" => "26/08/1995"
  })
transaction1.save()

transaction2 = Transaction.new({
  "merchant_id" => merchant2.id,
  "tag_id" => tag2.id,
  "price" => 15,
  "transaction_date" => "26/08/2000"
  })
transaction2.save()


transaction3 = Transaction.new({
  "merchant_id" => merchant3.id,
  "tag_id" => tag3.id,
  "price" => 25,
  "transaction_date" => "26/08/2005"
  })
transaction3.save()


transaction4 = Transaction.new({
  "merchant_id" => merchant4.id,
  "tag_id" => tag4.id,
  "price" => 30,
  "transaction_date" => "26/08/2010"
  })
transaction4.save()




binding.pry
nil
