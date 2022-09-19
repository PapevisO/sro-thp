# frozen_string_literal: true

class Blog::TextValidator < ActiveModel::Validator
  ALLOWED_TEXT_TYPES = %w[
    Blog::Post
    Blog::Comment
    Blog::Complaint
  ].freeze

  def validate(blog)
    if ALLOWED_TEXT_TYPES.include? blog.type
      validate_text_presence blog
    else
      validate_text_blank blog
    end
  end

  private

  def validate_text_presence(blog)
    if blog.text&.squish!.blank?
      blog
        .errors
        .add :text,
             :blank,
             message: "cannot set null empty or whitespace text for #{blog.type.demodulize}"
      return
    end

    return if blog.text.match?(/\A[[:print:]]*\Z/)

    blog
      .errors
      .add :text,
            :invalid_characters,
            message: "text can contain only printable and whitespace characters"
  end

  def validate_text_blank(blog)
    if blog.text.blank?
      blog.text = nil
    else
      blog
        .errors
        .add :text,
             :given,
             message: "cannot set text for #{blog.type.demodulize}"
    end
  end
end
