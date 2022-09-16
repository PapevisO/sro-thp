# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable,
         :async, :authentication_keys => [:email]

  validates :username,
            uniqueness: true,
            allow_nil: true,
            length: { maximum: 35 },
            format: { without: /http/, message: "urls are not allowed"}
  validates :email,
            uniqueness: true,
            presence: true,
            length: { maximum: 50 },
            format: { without: /http/, message: "urls are not allowed"}
  validates :first_name,
            length: { maximum: 35 },
            format: { without: /http/, message: "urls are not allowed"}
  validates :last_name,
            length: { maximum: 35 },
            format: { without: /http/, message: "urls are not allowed"}

  # address_fields
  %i[
    first_name
    last_name
    salutation
    country
    state
    city
    address_line
    zipcode
    phone
  ].each do |address_field|
    validates address_field, length: { maximum: 500 }
  end

  has_many :groups,
           inverse_of: :creator,
           foreign_key: :creator_id
  has_many :group_members,
           inverse_of: :member,
           foreign_key: :member_id
  has_many :groups_member_me,
           class_name: 'Group',
           through: :group_members,
           source: :group
end
