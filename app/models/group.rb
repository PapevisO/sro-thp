class Group < ApplicationRecord
  belongs_to :creator,
             class_name: 'User',
             foreign_key: :creator_id,
             inverse_of: :groups,
             required: true
  has_many :group_members,
           foreign_key: :group_id
  has_many :members, class_name: 'User', through: :group_members

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
