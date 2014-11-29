class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :service_id
      t.string :service_user_identifier
      t.integer :user_id

      t.timestamps
    end
  end
end
