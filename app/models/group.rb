# frozen_string_literal: true

class Group < ApplicationRecord
  before_validation :strip_whitespace
  validates :name,
            allow_blank: false,
            length: { maximum: 80 },
            format: { without: /http/, message: "urls are not allowed"}

  belongs_to :creator,
             class_name: 'User',
             foreign_key: :creator_id,
             inverse_of: :groups,
             optional: false
  has_many :group_members,
           foreign_key: :group_id,
           inverse_of: :group
  has_many :members, class_name: 'User', through: :group_members

  def strip_whitespace
    self.name = name.squish unless name.nil?
  end

  def joinable?(user = nil)
    return false if user.blank?
    return false if creator == user
    return false if members.include? user

    true
  end

  def creator_me?(user = nil)
    return false if user.blank?
    return false if creator != user

    true
  end
end
