class AddNameIndexToSocials < ActiveRecord::Migration[5.2]
  def up
    add_index :socials, :name, unique: true
  end

  def down
    remove_index :socials, :name, unique: true
  end
end
