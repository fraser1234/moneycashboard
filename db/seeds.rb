require('pry')
require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')

Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()

#tag
tag1 = Tag.new({
  "tag_name" => "Clothing"
  })
tag1.save()

tag2 = Tag.new({
  "tag_name" => "Hardware"
  })
tag2.save()

tag3 = Tag.new({
  "tag_name" => "Food"
  })
tag3.save()

tag4 = Tag.new({
  "tag_name" => "Drink"
  })
tag4.save()

#merchant

merchant1 = Merchant.new({
  "merchant_name" => "Tesco"
  })
merchant1.save()

merchant2 = Merchant.new({
  "merchant_name" => "Asda"
  })
merchant2.save()

merchant3 = Merchant.new({
  "merchant_name" => "Jewson"
  })
merchant3.save()

merchant4 = Merchant.new({
  "merchant_name" => "House of Fraser"
  })
merchant4.save()



transaction1 = Transaction.new({
  "merchant_id" => merchant1.id,
  "tag_id" => tag1.id,
  "price" => 20,
  "transaction_date" => Date.new(2000, 8, 26)
  })
transaction1.save()

transaction2 = Transaction.new({
  "merchant_id" => merchant2.id,
  "tag_id" => tag2.id,
  "price" => 15,
  "transaction_date" => Date.new(2005, 8, 26)
  })
transaction2.save()


transaction3 = Transaction.new({
  "merchant_id" => merchant3.id,
  "tag_id" => tag3.id,
  "price" => 25,
  "transaction_date" => Date.new(2010, 8, 26)
  })
transaction3.save()


transaction4 = Transaction.new({
  "merchant_id" => merchant4.id,
  "tag_id" => tag4.id,
  "price" => 30,
  "transaction_date" => Date.new(1995, 8, 26)
  })
transaction4.save()


binding.pry
nil
