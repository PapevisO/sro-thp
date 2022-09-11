module Helpers
  module NormalizeEmail
    extend self

    def normalize_email(email)
      return nil unless email

      email.strip.downcase.presence
    end
  end
end
