class EmployeesController < ApplicationController
    set :method_override, true
    #CREATE    
    get "/new_employee" do
      if !logged_in?
          erb :'employees/new'
      else
           @employee = current_employee
          session[:employee_id] = @employee.id
          redirect "/employees/#{@employee.id}"
      end
  end

  post "/new_employee" do        
      if (params[:name]).empty? ||(params[:email]).empty? ||(params[:password]).empty?
          redirect to '/new_employee'
      else
        @employee = Employee.create(:name => params[:name], :email => params[:email], :password => params[:password])                  
        session[:employee_id] = @employee.id
        redirect "/employees/#{@employee.id}"
      end   
  end

  #READ

  get '/employees' do    
      if !logged_in?
          redirect '/login'  
      end  
      @employee = Employee.all    
      erb :'/employees/all_employees'
  end

  get '/employees/:id' do 
      if !logged_in?
          redirect '/login'
      else 
      @employee = Employee.find_by_id(params[:id])
      erb :'/employees/show'
      end
  end    

  get '/employees/:id/customers' do 
      if !logged_in?
          redirect '/login'
      else 
      @employee = Employee.find_by_id(params[:id])
      
      erb :'/customers/index'
      end
  end 

#   UPDATE The functionalitty to allow for editing and deleting employees is here 
#   howerver in this interation of my project I do not want to allow employess to do this 
#   would be functionality for a admin portal.
  get "/employees/:id/edit" do
      if !logged_in?
          redirect '/login'
      end 
      @employee = Employee.find(params[:id])
      erb :'/employees/edit'
     end 
     
     patch "/employees/:id" do
       @employee = Employee.find(params[:id])
       @employee.update(name: params[:name], email: params[:email], password: params[:password])
       redirect to "/employees/#{@employee.id}"
     end

     #DELETE   
     delete "/employees/:id" do
       @employee = Employee.find(params[:id])
       @employee.destroy
       redirect to "/logout"
     end

  get '/login' do
      if !logged_in?
          erb :'/employees/login'
      else
          @employee = current_employee
          session[:employee_id] = @employee.id
          redirect "/employees/#{@employee.id}"
      end
  end

  post '/login' do        
      @employee = Employee.find_by(name: params[:name])
      if @employee && @employee.authenticate(params[:password])            
          session[:employee_id] = @employee.id            
          redirect "/employees/#{@employee.id}"            
      else                
          redirect '/'            
      end
  end
  
  get '/logout' do
      if logged_in?
      session.clear
      redirect '/'
      else 
          redirect '/'
      end 
  end
end





