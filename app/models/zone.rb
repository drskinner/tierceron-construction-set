class Zone < ApplicationRecord
  include Searchable

  belongs_to :owner, class_name: "User"

  validates_presence_of :name, :filename, :author, :owner_id, :min_vnum, :max_vnum

  scope :name_contains, ->(name) { where('name ILIKE ?', "%#{name}%") }
  scope :by_owner_id, ->(owner_id) { where(owner_id: owner_id) }

  def owner_id_display
    owner.name_display
  end
end
