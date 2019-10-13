class Mobile < ApplicationRecord
  include Searchable

  validates :vnum, presence: true, 
                   uniqueness: true
  validates :vnum, inclusion: { in: (User.current.present? ? User.current.owned_vnums : []) },
                   if: Proc.new { |m| User.current.builder? && m.vnum.present? }
  validates :keywords, presence: true

end
