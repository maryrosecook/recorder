require 'rubygems'
require 'sinatra'
require 'environment'
require 'model/data'
require 'json'

# setup

error do
  e = request.env['sinatra.error']
  puts e.to_s
  puts e.backtrace.join('\n')
  'Application error'
end

get '/' do
  haml :root
end

# store a datum in a bucket with an identifier
get "/set/:bucket/:identifier/:datum" do
  content_type :json
  response = "false"
  if params[:bucket] && params[:identifier] && params[:datum]
    Data.write_datum params[:bucket], params[:identifier], params[:datum]
    response = "true"
  end

  return { :result => response }.to_json
end

# get the data for bucket and identifier
get "/get/:bucket/:identifier.json" do
  content_type :json
  response = "false"
  if params[:bucket] && params[:identifier]
    response = Data.read_datum params[:bucket], params[:identifier]
  end

  return { :data => response }.to_json
end

# get all the data in a bucket
get "/get/:bucket.json" do
  content_type :json
  response = "false"
  if params[:bucket]
    response = Data.read_data params[:bucket]
  end

  return { :data => response }.to_json
end
