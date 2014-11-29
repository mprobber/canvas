class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.integer :site_id
      t.string :name

      t.timestamps
    end
  end
end
