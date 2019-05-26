class CreateZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zones do |t|
      t.string     :name, null: false
      t.string     :filename, null: false
      t.string     :author, null: false
      t.references :owner, index: true, foreign_key: { to_table: :users }
      t.integer    :min_vnum, null: false
      t.integer    :max_vnum, null: false

      t.timestamps
    end
  end
end
