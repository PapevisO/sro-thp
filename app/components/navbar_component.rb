# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  def user_signed_in?
    @user.present?
  end

  def groups_path
    '/groups'
  end
end
