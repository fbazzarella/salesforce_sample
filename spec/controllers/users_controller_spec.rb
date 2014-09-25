require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe 'GET #index' do
    context 'when logged in' do
      login!

      before { get :index }

      it { is_expected.to respond_with 200 }
    end

    context 'when logged out' do
      before { get :index }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe 'GET #omniauth_callback' do
    context 'when logged in' do
      login!

      let!(:auth_hash) { {'code' => '123456', 'state' => '654321'} }

      before do
        request.env['omniauth.auth'] = auth_hash
        get :omniauth_callback, provider: 'salesforce'
      end

      it { expect(@current_user.reload.salesforce_auth).to be_eql(auth_hash) }
      it { expect(flash[:notice]).to be_eql(I18n.t('omniauth.callback.salesforce')) }
      it { is_expected.to redirect_to(root_path) }
    end

    context 'when logged out' do
      before { get :omniauth_callback, provider: 'salesforce' }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe 'GET #omniauth_failure' do
    context 'when logged in' do
      login!

      before { get :omniauth_failure }

      it { expect(flash[:alert]).to be_eql(I18n.t('omniauth.failure.salesforce')) }
      it { is_expected.to redirect_to(root_path) }
    end

    context 'when logged out' do
      before { get :omniauth_failure }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe 'GET #omniauth_destroy' do
    context 'when logged in' do
      login!

      before { delete :omniauth_destroy }

      it { expect(@current_user.reload.salesforce_auth).to be_nil }
      it { expect(flash[:notice]).to be_eql(I18n.t('omniauth.destroy.salesforce')) }
      it { is_expected.to redirect_to(root_path) }
    end

    context 'when logged out' do
      before { delete :omniauth_destroy }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
