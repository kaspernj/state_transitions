class CreateStateTransitions < ActiveRecord::Migration[7.0]
  def change
    create_table :state_transitions do |t|
      t.references :resource, polymorphic: true, null: false
      t.references :user, polymorphic: true
      t.string :state_from, null: false
      t.string :state_to, null: false
      t.timestamps
    end
  end
end
