class CreateSiteNetworks < ActiveRecord::Migration
  def change
    create_table :site_networks do |t|
      t.integer :site_id
      t.integer :model_id

      t.timestamps
    end
  end
end
