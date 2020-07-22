class CustomersController < ApplicationController

    #CREATe
    get "/new_customer" do
      erb :'/customers/new'        
  end
  # t.string :company
  # t.string :contact_name
  # t.string :email
  # t.string :phone
  # t.text :web_specs
  
  post "/new_customer" do
      if (params[:company]).empty? ||(params[:contact_name]).empty? ||(params[:email]).empty? ||(params[:phone]).empty? ||(params[:web_specs]).empty? 
           redirect to '/new_customer'
      else 
        @customer = Customer.create(:company => params[:company], :contact_name => params[:contact_name],
          :email => params[:email], :phone => params[:phone],:web_specs =>params[:web_specs], :employee_id => current_employee.id )
                
          redirect "/customers/#{@customer.id}"
      end 
  end
  
  #READ
  get '/customers' do
      if !logged_in?
          redirect '/'
      else
      @customer = Customer.all        
      erb :'/customers/index'
      end
  end
  
  get '/my_customers' do
      # @customers = Customer.all
       @customer = current_employee.customers
       erb :'/customers/my_customers'
   end
  
  get '/customers/:id' do
      @customer = Customer.find_by_id(params[:id])
      erb :"/customers/show"
  end 
  
  
  #UPDATE
  get "/customers/:id/edit" do
      @customer = Customer.find_by_id(params[:id])
      erb :'/customers/edit'
     end 
     
     patch "/customers/:id" do
       @customer = Customer.find_by_id(params[:id])
       @customer.update(company: params[:company], contact_name: params[:contact_name], email: params[:email], phone: params[:phone], web_specs: params[:webspecs]) 
       redirect to "/customers/#{@customer.id}"
     end
  
     #DELETE   
     delete "/customers/:id" do
       @customer = Customer.find(params[:id])
       @customer = Customer.destroy(params[:id])
       redirect to "/employees/:id"
     end
  end  
  
 