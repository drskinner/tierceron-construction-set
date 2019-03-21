# frozen_string_literal: true

class CreateSocials < ActiveRecord::Migration[5.2]
  def change
    # these column names are ugly but they match Smaug's field names
    create_table :socials do |t|
      t.string :name, null: false
      t.text :char_no_arg, null: false
      t.text :others_no_arg
      t.text :char_obj
      t.text :others_obj
      t.text :char_found
      t.text :others_found
      t.text :vict_found
      t.text :char_auto
      t.text :others_auto

      t.timestamps
    end
  end
end
