class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  validates :first_name, presence: true
  validates :role_id, presence: true

  after_initialize :set_default_role

  def set_default_role
    self.role = Role.find_by(name: 'guest') if self.new_record?
  end

  def internal?
    role.name != 'guest'
  end

  def name_display
    last_name.blank? ? first_name : "#{first_name} #{last_name}"
  end

  def role_id_display
    role.to_s
  end
end
