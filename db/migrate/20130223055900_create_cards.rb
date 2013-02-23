class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.text :address
      t.text :message

      t.timestamps
    end
  end
end
