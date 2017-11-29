require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry-byebug' )

require_relative( './models/transaction' )

get '/' do
  erb(:home)
end

get '/transactions' do # index
  @transactions = Transaction.all().reverse
  erb( :"transaction/index" )
end

get '/transactions/new' do # new
  @merchants = Merchant.all
  @tags = Tag.all
  erb( :"transaction/new" )
end

post '/transactions' do # create
  @transactions = Transaction.new( params )
  @transactions.save()
  redirect to "/transactions"
end

get '/transactions/:id' do # show
  @transactions = Transaction.find( params[:id] )
  erb( :"transaction/show" )
end


get '/transactions/:id/edit' do # edit
  @transaction = Transaction.find( params[:id] )
  @tags = Tag.all
  @merchants = Merchant.all
  erb( :"transaction/edit" )
end

put '/transactions/:id' do # update
  transaction = Transaction.new( params )
  transaction.update
  redirect to '/transactions'
end

delete '/transactions/:id' do # delete for transaction
  transaction = Transaction.find( params[:id] )
  transaction.delete()
  redirect to '/transactions'
end

delete '/transactions/by_tag/:id' do # delete for tag
  tag = Tag.find( params[:id] )
  tag.delete()
  redirect to '/transactions'
end

delete '/transactions/by_merchant/:id' do # delete for merchants
  merchant = Merchant.find( params[:id] )
  merchant.delete()
  redirect to '/transactions'
end



get '/transactions/by_tag/:id' do
  @transaction_by_tag = Transaction.by_tag(params[:id])
  erb(:"tag/by_tag")
end

get '/transactions/by_merchant/:id' do
  @transaction_by_merchant = Transaction.by_merchant(params[:id])
  erb(:"merchant/by_merchant")
end



#new tag/edit tag
get '/tags/new' do #new
   erb(:"tag/new_tag")
end

post '/tags' do
  Tag.new(params).save()
  redirect to "/transactions"
end

get '/tags' do
  @tags = Tag.all()
  erb( :"tag/tags" )
end

#new merchant
get '/merchants/new' do
  erb(:"merchant/new_merchant")
end

post '/merchants' do
  Merchant.new(params).save()
  redirect to "/transactions"
end

get '/merchants' do
  @merchants = Merchant.all()
  erb( :"merchant/merchants" )
end
