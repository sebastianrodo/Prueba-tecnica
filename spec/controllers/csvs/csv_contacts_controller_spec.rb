require 'rails_helper'

RSpec.describe Csvs::ContactsController, type: :controller do
  after do
    DatabaseCleaner.clean
  end

  describe 'GET #index' do
    subject { get :index, params: params }

    let(:contact) { create :contact }
    let(:params) { { csv_id: contact.csv_id } }

    before do
      sign_in contact.user
      subject
    end

    it { expect(assigns(:contacts).size).to eq(1) }
    it { expect(response).to have_http_status '200' }
    it { is_expected.to render_template :index }
  end

  describe 'POST #create' do
    let(:csv) { create(:csv) }

    let(:params) do
      {
        csv_id: csv.id,
        header1: "name",
        header2: "date_of_birth",
        header3: "phone_number",
        header4: "address",
        header5: "credit_card_number",
        header6: "credit_card_type",
        header7: "email"
      }
    end

    context 'as an authenticated user' do
      let(:invalid_params) do
        {
          csv_id: csv.id,
          header1: "name",
          header2: "date_of_birth",
          header3: "phone_number",
          header4: "address",
          header5: "sdd",
          header6: "credit_card_type",
          header7: "email"
        }
      end

      before do
        sign_in csv.user
      end

      context 'with valid attributes' do
        it 'adds a contact' do
          expect do
            post :create, params: params
          end.to change(Contact, :count)
        end
      end

      context 'with invalid attributes' do
        it 'adds a contact' do
          expect do
            post :create, params: invalid_params
          end.not_to change(Contact, :count)
        end
      end
    end

    context 'as a guest' do
      it 'returns a 302 response' do
        post :create, params: params
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        post :create, params: params
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
