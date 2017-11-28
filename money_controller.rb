require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry-byebug' )

require_relative( './models/transaction' )

get '/' do
  erb(:home)
end

get '/transaction' do # index
  @transactions = Transaction.all().reverse
  erb( :index )
end

get '/transaction/new' do # new
  @merchants = Merchant.all
  @tags = Tag.all
  erb( :new )
end

post '/transaction' do # create
  @transactions = Transaction.new( params )
  @transactions.save()
  redirect to "/transaction"
end

get '/transaction/:id' do # show
  @transactions = Transaction.find( params[:id] )
  erb( :show )
end


get '/transaction/:id/edit' do # edit
  @transaction = Transaction.find( params[:id] )
  @tags = Tag.all
  @merchants = Merchant.all
  erb( :edit )
end

put '/transaction/:id' do # update
  transaction = Transaction.new( params )
  transaction.update
  redirect to '/transaction'
end

delete '/transaction/:id' do # delete
  transaction = Transaction.find( params[:id] )
  transaction.delete()
  redirect to '/transaction'
end

get '/transaction/by_tag/:id' do
  @transaction_by_tag = Transaction.by_tag(params[:id])
  erb(:by_tag)
end
