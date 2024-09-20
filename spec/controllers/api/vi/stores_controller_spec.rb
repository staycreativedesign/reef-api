require 'rails_helper'

RSpec.describe Api::V1::StoresController do
  context "happy path" do
    let(:store) { create(:store) }

    describe "GET #index" do
      before do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
        stores = JSON.parse(response.body)
      end
    end

    describe "GET #show" do
      before do
        get :show, params: { id: store.id }
      end

      it "returns http success" do
        store = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end
    end


    describe "PUT/PATCH #update" do
      let(:params) do
        {
          "data": {
            "attributes": {
              "name": "Changed the name"
            }
          },
          "id": store.id
        }
      end

      before do
        patch :update, params: params
      end

      it "returns http success" do
        store.reload
        expect(response).to have_http_status(:ok)
        expect(store.name).to eq(params[:data][:attributes][:name])
      end
    end


    describe "POST #create" do
      let(:params) do
        {
          "data": {
            "attributes": {
              "name": "xx yy",
              "description": "fooo",
              "address": "fooo"
            }
          }
        }
      end

      before do
        post :create, params: params
      end

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end
    end


    describe "DELETE #destroy" do
      let(:store_to_delete) { create(:store) }

      let(:params) do
        {
          "id": store_to_delete.id
        }
      end

      before do
        delete :destroy, params: params
      end

      it "returns http no content" do
        expect(response).to have_http_status(:no_content)
      end
    end
  end


  context "unhappy path" do
    describe "get #show" do
      before do
        get :show, params: { id: 1 }
      end

      it "returns not_found " do
        expect(response).to have_http_status(:not_found)
      end
    end

    describe "POST #create" do
      it "returns unprocessable_entity" do
        expect { create(:store, name: '') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end

