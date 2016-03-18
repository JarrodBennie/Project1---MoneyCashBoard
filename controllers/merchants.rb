require "sinatra"
require "sinatra/contrib/all"
require_relative "../models/account"

get "/merchants" do
  if params[ :search ]
    options = { "transactions" => Transaction.all, "merchants" => Merchant.search( params[ :search ]), "tags" => Tag.all } 
  else
    options = { "transactions" => Transaction.all, "merchants" => Merchant.all, "tags" => Tag.all }
  end
  @account = Account.new( options )
  erb :"merchants/index"
end

get "/merchants/new" do
  erb :"merchants/new"
end

get "/merchants/:id" do
  @merchant = Merchant.find( params[ :id ])  
  options = { "transactions" => Transaction.all, "merchants" => Merchant.all, "tags" => Tag.all }
  @account = Account.new( options )
  erb :"merchants/show"
end

post "/merchants" do
  @merchant = Merchant.create( params )
  redirect to "/merchants"
end

get "/merchants/:id/edit" do
  @merchant = Merchant.find( params[ :id ])
  options = { "transactions" => Transaction.all, "merchants" => Merchant.all, "tags" => Tag.all }
  @account = Account.new( options )
  erb :"merchants/edit"
end

post "/merchants/:id" do
  @merchant = Merchant.new( params )
  @merchant.update
  redirect to "/merchants"
end