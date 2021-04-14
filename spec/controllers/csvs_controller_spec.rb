# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvsController, type: :controller do
  after do
    DatabaseCleaner.clean
  end


  describe 'GET #show' do
    subject { get :show, params: params }

    context 'expect to be successfully, render show' do
      let(:params) { { id: csv.id } }
      let(:csv) { create(:csv) }

      before do
        sign_in csv.user
        subject
      end

      it { expect(response).to be_successful }
      it { expect(response).to have_http_status '200' }
      it { is_expected.to render_template :show }
    end

    context 'expect to be fail, the csv file to show not exist' do
      let(:csv) { create(:csv, :custom_id) }
      let(:params) { { id: 2 } }

      before do
        sign_in csv.user
        subject
      end

      it { expect(subject).to redirect_to(users_contacts_url) }
    end
  end

  describe 'GET #new' do
    subject { get :new, params: {} }

    context 'expect be successfully' do
      let(:user) { create(:user) }

      before do
        sign_in user
        subject
      end

      it { expect(assigns(:csv)).not_to be_nil }
      it { expect(assigns(:csv)).to be_a_new(Csv) }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status '200' }
      it { is_expected.to render_template :new }
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    let(:csv_params) do
      { file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/contacts.csv"),
        user_id: user.id
      }
    end

    context 'as an authenticated user' do
      let(:invalid_csv_params) do
        { user_id: user.id }
      end

      before do
        sign_in user
      end

      context 'with valid attributes' do
        it 'adds a csv file' do
          expect do
            post :create, params: { csv: csv_params }
          end.to change(Csv, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'adds a csv file' do
          expect do
            post :create, params: { csv: invalid_csv_params }
          end.not_to change(Csv, :count)
        end
      end
    end

    context 'as a guest' do
      it 'expect returns a 302 response redirects to the sign-in page' do
        post :create, params: { csv: csv_params }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'PATCH #update' do
    subject { put :update, params: params }

    context 'update csv, signed in' do
      let(:csv) { create(:csv) }
      let(:new_file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/contacts2.csv") }
      let(:params) do
        { id: csv.id,
          csv: { file: new_file }
        }
      end

      before do
        sign_in csv.user
      end

      it { expect { subject }.to change { csv.reload.file.blob.filename } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status '200' }
    end

    context 'update a csv that not belongs to you' do
      let(:another_user) { create(:user) }
      let(:csv) { create(:csv) }
      let(:new_file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/contacts2.csv") }
      let(:params) do
        { id: csv.id,
          csv: { file: new_file }
        }
      end

      before do
        sign_in another_user
        subject
      end

      it { expect(csv.reload.file.blob.filename ).to eq 'contacts.csv' }
    end

    context 'expect fail, invalid attributes' do
      let(:csv) { create(:csv) }
      let(:params) do
        { id: csv.id,
          csv: { state: nil }
        }
      end

      before do
        sign_in csv.user
      end

      it { expect { subject }.not_to change { csv.reload.state } }
    end

    context 'try to update without sign in, as a guest' do
      let(:csv) { create(:csv) }
      let(:new_file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/contacts2.csv") }
      let(:params) do
        { id: csv.id,
          csv: { file: new_file }
        }
      end

      it { expect { subject }.not_to change { csv.reload.file.blob.filename } }

      it 'redirects to the sign-in page' do
        subject
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params }

    context 'delete, with an authenticated user' do
      let(:csv) { create(:csv) }
      let(:params) { { id: csv.id } }

      before do
        sign_in csv.user
      end

      it { expect { subject }.to change(Csv, :count).by(-1) }
    end

    context 'try to delete a csv that not belongs to you' do
      let(:another_user) { create(:user) }
      let(:csv) { create(:csv) }
      let(:params) { { id: csv.id } }

      before do
        sign_in another_user
        csv
      end

      it { expect { subject }.not_to change(Csv, :count) }
    end

    context 'try to delete without sign in, as a guest' do
      let(:csv) { create(:csv) }
      let(:params) { { id: csv.id } }

      before do
        csv
      end

      it { expect { subject }.not_to change(Csv, :count) }

      it 'redirects to the sign-in page' do
        subject
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
