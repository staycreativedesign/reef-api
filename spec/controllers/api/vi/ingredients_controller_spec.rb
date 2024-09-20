require 'rails_helper'

RSpec.describe Api::V1::IngredientsController do
  context "happy path" do
    let!(:item) { create(:item) }

    describe "GET #index" do
      before do
        get :index, params: { item_id: item.id }
      end

      context "when item has no ingredients" do
        it "returns http success" do
          expect(response).to have_http_status(:ok)
        end


        it "informs the user no ingredients available" do
          info = JSON.parse(response.body)["info"]
          expect(info).to eq("No records available, view POST api endpoint documentation for object creation.")
        end
      end

      context "when item has ingredients" do
        let!(:ingredient) { create(:ingredient, item: item) }

        it "returns http success" do
          expect(item.ingredients.count).to eq(1)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe "GET #show" do
      let(:ingredient) { create(:ingredient, item: item) }

      before do
        get :show, params: { id: ingredient.id }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end
    end

    describe "PUT/PATCH #update" do
      let(:ingredient) { create(:ingredient, item: item) }

      let(:params) do
        {
          "data": {
            "attributes": {
              "name": "Changed the name"
            }
          },
          "id": ingredient.id
        }
      end

      before do
        patch :update, params: params
      end

      it "returns http success" do
        ingredient.reload
        expect(response).to have_http_status(:ok)
        expect(ingredient.name).to eq(params[:data][:attributes][:name])
      end
    end

    describe "POST #create" do
      let(:params) do
        {
          "data": {
            "attributes": {
              "name": Faker::Restaurant.name,
              "quantity": Faker::Number.within(range: 1..10)

            }
          }, "item_id": item.id
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
      let(:ingredient_to_delete) { create(:ingredient) }

      let(:params) do
        {
          "id": ingredient_to_delete.id
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
      end
    end
  end
end
