class AddUserableToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :userable_id, :integer
    add_column :users, :userable_type, :string
  end
end
