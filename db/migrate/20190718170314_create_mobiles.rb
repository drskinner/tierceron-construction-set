class CreateMobiles < ActiveRecord::Migration[5.2]
  def change
    create_table :mobiles do |t|
      t.integer :vnum, null: false
      t.string  :keywords, null: false
      t.string  :short_desc, null: false
      t.string  :long_desc, null: false
      t.text    :description
      t.string  :race, null: false
      t.string  :klass, null: false
      t.string  :position, null: false
      t.string  :defposition, null: false
      t.string  :spec_funname
      t.string  :sex, null: false
      t.text    :act_flags, array: true, default: []
      t.text    :affected_by, array: true, default: []
      t.integer :alignment, null: false
      t.integer :level, null: false
      t.integer :mobthac0, null: false
      t.integer :ac, null: false
      t.integer :gold, null: false
      t.integer :exp, null: false
      t.integer :hitnodice, null: false
      t.integer :hitsizedice, null: false
      t.integer :hitplus, null: false
      t.integer :damnodice, null: false
      t.integer :damsizedice, null: false
      t.integer :damplus, null: false
      t.integer :height, null: false
      t.integer :weight, null: false
      t.integer :numattacks, null: false
      t.integer :hitroll, null: false
      t.integer :damroll, null: false
      t.integer :saving_poison_death, default: 0
      t.integer :saving_wand, default: 0
      t.integer :saving_para_petri, default: 0
      t.integer :saving_breath, default: 0
      t.integer :saving_spell_staff, default: 0
      t.integer :str, default: 13
      t.integer :int, default: 13
      t.integer :wis, default: 13
      t.integer :dex, default: 13
      t.integer :con, default: 13
      t.integer :cha, default: 13
      t.integer :lck, default: 13
      t.text    :speaks, array: true, default: []
      t.text    :speaking, array: true, default: []
      t.text    :xflags, array: true, default: []
      t.text    :resistant, array: true, default: []
      t.text    :immune, array: true, default: []
      t.text    :susceptible, array: true, default: []
      t.text    :attacks, array: true, default: []
      t.text    :defenses, array: true, default: []
      t.integer :shop_data, array: true
      t.integer :repair_data, array: true

      t.timestamps
    end

    add_index :mobiles, :vnum, unique: true
  end
end
