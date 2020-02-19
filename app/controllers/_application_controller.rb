class ApplicationController < Sinatra::Base
  set :method_override, true
  set :views, 'app/views'

  get "/" do 
    erb :welcome
  end

end
