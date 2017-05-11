class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :email, null: false, unique: true
      t.string :hashed_password, null: false

      t.timestamps
    end
  end
end
