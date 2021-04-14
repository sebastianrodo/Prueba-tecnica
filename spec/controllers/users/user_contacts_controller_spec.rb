require 'rails_helper'

RSpec.describe Users::ContactsController, type: :controller do
  after do
    DatabaseCleaner.clean
  end

  describe 'GET #index' do
    subject { get :index, params: params }

    let(:contact) { create :contact }
    let(:params) { { id: contact.user_id } }

    before do
      sign_in contact.user
      subject
    end

    it { expect(assigns(:contacts).size).to eq(1) }
    it { expect(response).to have_http_status '200' }
    it { is_expected.to render_template :index }
  end
end
