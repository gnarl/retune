# myapp.rb
require 'sinatra'

get '/' do 
  'Hello earth!'
end

get '/form' do
  erb :form    
end

post '/form' do
  "You said '#{params[:message]}.'"
end

# raw get
#  explain routes
#  explain block
#
# explain symbols in a GET request
#   get '/hello/:name' do 
#     params[:name]
#   end
# 
# explain string interpolation using params
#   get '/hello/:name/:city' do 
#     "Hello #{params[:name]}! Welcome to #{params[:city]}."
#   end
#  params.to_s
#
# explain last thing returned
#     displays a string
#     number throws LintError
#
# explain get /form
#
#
# explain post /form, POST route
#
# explain 404
#   not_found do  
#     status 404  
#     '404: Not Found'  
#   end  
#
