require './config/environment'

class ApplicationController < Sinatra::Base  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end
  
  get "/" do
    erb:"/triforge"
  end 
  
  helpers do     
    def current_employee
      if @employee != nil
        @employee
      else
      @employee = Employee.find_by_id(session[:employee_id])
      end
    end

    def logged_in?
      !!session[:employee_id]
    end

  end
end
