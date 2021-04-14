require 'rails_helper'

RSpec.describe Users::CsvsController, type: :controller do
  after do
    DatabaseCleaner.clean
  end

  describe 'GET #index' do
    subject { get :index, params: params }

    let(:csv) { create :csv }
    let(:params) { { id: csv.user_id } }

    before do
      sign_in csv.user
      subject
    end

    it { expect(assigns(:csvs).size).to eq(1) }
    it { expect(response).to have_http_status '200' }
    it { is_expected.to render_template :index }
  end
end
