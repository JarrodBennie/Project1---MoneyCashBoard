require "sinatra"
require "sinatra/contrib/all"
require_relative "../models/account"

get "/tags" do
  if params[ :search ]
    options = {
      "transactions" => Transaction.find_this_month,
      "merchants" => Merchant.all,
      "tags" => Tag.find_where( params[ :search ])
    } 
  else
    options = { "transactions" => Transaction.find_this_month, "merchants" => Merchant.all, "tags" => Tag.all }
  end
  @account = Account.new( options )
  if @account.tags.size == 0
    erb :"/tags/empty"
  else
    erb :"/tags/index"
  end
end

get "/tags/new" do
  erb :"/tags/new"
end

get "/tags/:id" do
  @tag = Tag.find( params[ :id ])  
  options = { "transactions" => Transaction.all, "merchants" => Merchant.all, "tags" => Tag.all }
  @account = Account.new( options )
  if @account.transactions.select { |t| t.tag_id == @tag.id }.size == 0
    erb :"tags/show_empty"
  else
    erb :"tags/show"
  end
end

post "/tags" do
  @tag = Tag.create( params )
  redirect to "/tags"
end

get "/tags/:id/edit" do
  @tag = Tag.find( params[ :id ])
  options = { "transactions" => Transaction.all, "merchants" => Merchant.all, "tags" => Tag.all }
  @account = Account.new( options )
  erb :"/tags/edit"
end

post "/tags/:id" do
  @tag = Tag.new( params )
  @tag.update
  redirect to "/tags"
end