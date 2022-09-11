# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # https://github.com/plataformatec/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update

    def after_sign_in_path_for(resource_or_scope)
      if session[:custom_redirect_after_registration]
        session[:custom_redirect_after_registration].tap do
          session[:custom_redirect_after_registration] = nil
        end
      else
        stored_location_for(resource_or_scope) || super
      end
    end

    def after_sign_out_path_for(resource_or_scope)
      if is_navigational_format? && !request.xhr?
        request.referer || super
      else
        super
      end
    end

    private

    def before_action_with_error_flash(error_message)
      # repeat all before_action, because of our prepend_before_action
      set_top_menu_presenter(nil)
      enable_blackout
      disable_alerts
      set_javascript_folder_name(:sign_in_page)

      flash[:error] = find_message(error_message, authentication_keys: (
        resource_class.authentication_keys.join(', ').capitalize
      ))

      self.resource = resource_class.new sign_in_params
      respond_with_navigational(resource) { render :new }
    end
  end
end
