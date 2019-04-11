class User < ApplicationRecord
  include Searchable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  validates :first_name, presence: true
  validates :role_id, presence: true
  validates :pronoun_class, presence: true

  after_initialize :set_default_role

  scope :name_contains, ->(name) { where('first_name ILIKE ?', "%#{name}%") }
  scope :by_role_id, ->(role_id) { where(role_id: role_id) }

  PRONOUN_CLASSES = %i[female male neutral]

  def set_default_role
    self.role = Role.find_by(name: 'guest') if self.new_record?
  end

  # set current user for use in models by User.current
  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.pronoun_class_collection
    PRONOUN_CLASSES.map { |p| [I18n.t("lists.user.pronouns.#{p}.label"), p] }
  end

  def internal?
    role.name != 'guest'
  end

  def name_display
    last_name.blank? ? first_name : "#{first_name} #{last_name}"
  end

  def pronoun_class_display
    I18n.t("lists.user.pronouns.#{pronoun_class}.label")
  end

  def role_id_display
    role.to_s
  end
end
