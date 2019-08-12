class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
  end

  helpers Sinatra::Param
end
