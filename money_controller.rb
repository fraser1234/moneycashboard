require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry-byebug' )

require_relative( './models/transaction' )

get '/transaction' do # index
  @transaction = Transaction.all()
  erb( :index )
end

get '/transaction/new' do # new
  erb( :new )
end

post '/transaction' do # create
  @transaction = Transaction.new( params )
  @transaction.save()
  redirect to "/transaction"
end

get '/transaction/:id' do # show
  @transaction = Transaction.find( params[:id] )
  erb( :show )
end


get '/transaction/:id/edit' do # edit
  @transaction = Transaction.find( params[:id] )
  @tag = Tag.all
  @merchant = Merchant.all
  erb( :edit )
end

put '/transaction/:id' do # update
  Transaction.new( params ).update
  redirect to '/transaction'
end

delete '/transaction/:id' do # delete
  transaction = Transaction.find( params[:id] )
  transaction.delete()
  redirect to '/transaction'
end
