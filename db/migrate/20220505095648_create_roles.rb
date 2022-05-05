class CreateRoles < ActiveRecord::Migration[7.0]
  def up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :roles
  end
  
end
