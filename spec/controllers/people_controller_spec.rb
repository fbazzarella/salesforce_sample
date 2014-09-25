require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  render_views

  describe 'GET #index' do
    context 'when logged in' do
      login!

      let!(:person1) { create(:person, user: @current_user) }
      let!(:person2) { create(:person) }

      before { get :index }

      it { expect(assigns(:people)).to be_a(ActiveRecord::Relation) }
      it { expect(assigns(:people)).to include(person1) }
      it { expect(assigns(:people)).to_not include(person2) }
      it { is_expected.to respond_with 200 }
    end

    context 'when logged out' do
      before { get :index }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe 'GET #new' do
    context 'when logged in' do
      login!

      before { get :new }

      it { expect(assigns(:person)).to be_a_new(Person) }
      it { expect(assigns(:person).user).to be_eql(@current_user) }
      it { is_expected.to respond_with 200 }
    end

    context 'when logged out' do
      before { get :new }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe 'POST #create' do
    context 'when logged in' do
      login!
  
      def post_create(params = {})
        post :create, person: attributes_for(:person).except(:user_id).merge!(params)
      end

      context 'when valid attributes' do
        before { post_create }

        it { expect(@current_user.people.count).to_not be_zero }
        it { is_expected.to redirect_to(people_path) }
      end

      context 'when invalid attributes' do
        before { post_create(last_name: '') }

        it { expect(@current_user.people.count).to be_zero }
        it { expect(assigns(:person)).to be_a_new(Person) }
        it { is_expected.to respond_with 200 }
      end
    end

    context 'when logged out' do
      before { post :create }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
