class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :vnum, null: false
      t.string  :keywords, null: false
      t.string  :item_type, null: false
      t.string  :short_desc, null: false
      t.string  :long_desc, null: false
      t.text    :full_desc
      t.string  :action_desc
      t.text    :flags, array: true, default: []
      t.text    :wear_flags, array: true, default: []
      t.text    :magic_flags, array: true, default: []
      t.integer :value0, default: 0
      t.integer :value1, default: 0
      t.integer :value2, default: 0
      t.integer :value3, default: 0
      t.integer :value4, default: 0
      t.integer :value5, default: 0
      t.integer :weight, default: 0
      t.integer :cost, default: 0
      t.integer :rent, default: 0
      t.integer :level, default: 0
      t.integer :layers, default: 0
      t.string  :spells, array: true, default: []

      t.timestamps
    end

    add_index :items, :vnum, unique: true
  end
end
