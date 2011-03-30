require 'rubygems'
require 'haml'

require 'sinatra' unless defined?(Sinatra)

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end
