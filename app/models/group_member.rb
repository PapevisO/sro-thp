class GroupMember < ApplicationRecord
  belongs_to :member,
             class_name: 'User',
             foreign_key: :member_id,
             required: true
  belongs_to :group, required: true
end
