# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    def create
      super do |user|
        unless User.find_by(email: Helpers::NormalizeEmail.normalize_email(user.email))
          flash[:error] = "This email address has not been found. Please register"
        end
      end
    end
  end
end
