class User < ApplicationRecord
  has_one :students_application
  has_one :student
  has_many :school_admins
  has_many :schools, through: :school_admins
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
