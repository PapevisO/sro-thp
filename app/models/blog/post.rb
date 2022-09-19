# frozen_string_literal: true

class Blog::Post < Blog
  validate :is_root

  private

  def is_root
    errors.add_to_base(
      "Post must be a root Blog entity, e.g. parent_id is null"
    ) unless root?
  end
end
