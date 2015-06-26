class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :username
      t.string    :email
      t.boolean   :flag
      t.datetime  :current_time

      t.timestamps null: false
    end
  end
end
