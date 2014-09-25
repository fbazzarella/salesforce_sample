class UsersController < ApplicationController
  def index
  end

  def omniauth_callback
    current_user.update_attribute(:salesforce_auth, request.env['omniauth.auth'])
    redirect_to(root_path, notice: I18n.t('omniauth.callback.salesforce'))
  end

  def omniauth_failure
    redirect_to(root_path, alert: I18n.t('omniauth.failure.salesforce'))
  end

  def omniauth_destroy
    current_user.update_attribute(:salesforce_auth, nil)
    redirect_to(root_path, notice: I18n.t('omniauth.destroy.salesforce'))
  end
end
