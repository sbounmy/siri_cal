class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :siriable_login
      t.string :siriable_password

      t.timestamps
    end
  end
end
