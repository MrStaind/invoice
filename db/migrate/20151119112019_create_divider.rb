class CreateDivider < ActiveRecord::Migration
  def change
    create_table :dividers do |t|
      t.integer :user_id, :invoice_id, :analytic_id
      
    end
    add_monetize :dividers, :amount
  end
end
