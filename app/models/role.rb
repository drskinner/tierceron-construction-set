class Role < ApplicationRecord

  has_many :users

  validates_presence_of :name, :rank

  def self.role_collection(user = nil)
    if user.present?
      Role.where('rank <= ?', user.role.rank).map { |r| [I18n.t("lists.role.#{r.name}"), r.id] }
    else
      Role.all.map { |r| [I18n.t("lists.role.#{r.name}"), r.id] }
    end
  end

  def to_s
    I18n.t("lists.role.#{name}")
  end
end
