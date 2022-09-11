# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :store_redirect_after_registration_location

    def create
      # instead of build_resource
      sign_up_params[:email] = Helpers::NormalizeEmail.normalize_email(sign_up_params[:email])

      self.resource = resource_class.find_by(email: sign_up_params[:email])

      super
    end

    protected

    # allow params from url
    def build_resource(hash = {})
      hash_with_params = hash.merge(sign_up_params)
      super(hash_with_params)
    end

    # redirect to some page if url has redirect_after_registration parameter
    # https://stackoverflow.com/a/9838949/3574379
    def store_redirect_after_registration_location
      redirect_after_registration = params[:redirect_after_registration]

      return if redirect_after_registration.blank?

      session[:custom_redirect_after_registration] = redirect_after_registration
    end

    def after_sign_up_path_for(resource)
      after_sign_in_path_for(resource)
    end
  end
end
