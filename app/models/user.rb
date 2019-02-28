class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :role_id, presence: true

  after_initialize :set_default_role

  def set_default_role
    self.role_id = Role.find_by(name: 'guest').id if self.new_record?
  end

  def name_display
    last_name.blank? ? first_name : "#{first_name} #{last_name}"
  end
end
