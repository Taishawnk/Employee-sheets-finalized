class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :company
      t.string :contact_name
      t.string :email
      t.string :phone
      t.text :web_specs
      t.integer :employee_id  
    end
  end
end
