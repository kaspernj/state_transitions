class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :state, default: "new", null: false
      t.timestamps
    end
  end
end
