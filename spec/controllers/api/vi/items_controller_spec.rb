require 'rails_helper'

RSpec.describe Api::V1::ItemsController do
  context "happy path" do
    let!(:store) { create(:store) }

    describe "GET #index" do
      before do
        get :index, params: { store_id: store.id }
      end

      context "when store has no items" do
        it "returns http success" do
          expect(response).to have_http_status(:ok)
        end


        it "informs the user no items available" do
          info = JSON.parse(response.body)["info"]
          expect(info).to eq("No records available, view POST api endpoint documentation for object creation.")
        end
      end

      context "when store has items" do
        let!(:item) { create(:item, store: store) }

        it "returns http success" do
          expect(store.items.count).to eq(1)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe "GET #show" do
      let(:item) { create(:item, store: store) }

      before do
        get :show, params: { id: item.id }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end
    end


    describe "PUT/PATCH #update" do
      let(:item) { create(:item, store: store) }

      let(:params) do
        {
          "data": {
            "attributes": {
              "name": "Changed the name"
            }
          },
          "id": item.id
        }
      end

      before do
        patch :update, params: params
      end

      it "returns http success" do
        item.reload
        expect(response).to have_http_status(:ok)
        expect(item.name).to eq(params[:data][:attributes][:name])
      end
    end

    describe "POST #create" do
      let(:params) do
        {
          "data": {
            "attributes": {
              "name": Faker::Restaurant.name,
              "description":  Faker::Food.dish,
              "price_cents": 613

            }
          }, "store_id": store.id
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
      let(:item_to_delete) { create(:item) }

      let(:params) do
        {
          "id": item_to_delete.id
        }
      end

      before do
        delete :destroy, params: params
      end

      it "returns http no content" do
        expect(response).to have_http_status(:no_content)
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
          expect { create(:item, name: '') }.to raise_error(ActiveRecord::RecordInvalid)
        end

        describe "numbers not used for price_cents" do
          let(:params) do
            {
              "data": {
                "attributes": {
                  "name": Faker::Restaurant.name,
                  "description":  Faker::Food.dish,
                  "price_cents": "aaa"

                }
              }, "store_id": store.id
            }
          end
          before do
            post :create, params: params
          end

          it "returns http unprocessable_entity" do
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end
  end
end
