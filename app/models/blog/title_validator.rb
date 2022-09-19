# frozen_string_literal: true

class Blog::TitleValidator < ActiveModel::Validator
  ALLOWED_TITLE_TYPES = %w[
    Blog::Post
  ].freeze

  def validate(blog)
    if ALLOWED_TITLE_TYPES.include? blog.type
      validate_title_presence blog
    else
      validate_title_blank blog
    end
  end

  private

  def validate_title_presence(blog)
    if blog.title&.squish!.blank?
      blog
        .errors
        .add :title,
             :blank,
             message: "cannot set null empty or whitespace title for #{blog.type.demodulize}"
      return
    end

    return if blog.title.match?(/\A[[:print:]]*\Z/)

    blog
      .errors
      .add :title,
            :invalid_characters,
            message: "title can contain only printable and whitespace characters"
  end

  def validate_title_blank(blog)
    if blog.title.blank?
      blog.title = nil
    else
      blog
        .errors
        .add :title,
             :given,
             message: "cannot set title for #{blog.type.demodulize}"
    end
  end
end
