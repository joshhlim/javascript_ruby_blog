class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, uniqueness: true, null: false
      t.string :email, uniqueness: true, null: false
      t.string :hashed_password, null: false

      t.timestamps null: false
    end
  end
end
