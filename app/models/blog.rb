# frozen_string_literal: true

class Blog < ApplicationRecord
  has_ltree_hierarchy
  validates_with Blog::TitleValidator
  validates_with Blog::TextValidator

  belongs_to :user, required: true
  belongs_to :group, required: true

end
