module Api
  module V1
    class IngredientsController < ApplicationController
      before_action :find_item, only: [ :index, :create ]
      before_action :find_ingredient, only: [ :update, :destroy ]

      def index
        @ingredients = @item.ingredients

        raise BlankObjectError unless @ingredients.present?

        render json: @ingredients, status: :ok
      end

      def show
        @ingredient = Ingredient.find(params[:id])

        render json: @ingredient, status: :ok
      end

      def create
        @ingredient = @item.ingredients.create!(ingredient_params)

        render json: @ingredient, status: :created
      end

      def update
        @ingredient.update!(ingredient_params)

        render json: @ingredient, status: :ok
      end

      def destroy
        @ingredient.destroy!

        render json: nil, status: :no_content
      end

      private

      def find_item
        @item = Item.find(params[:item_id])
      end


      def find_ingredient
        @ingredient = Ingredient.find(params[:id])
      end

      def ingredient_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
    end
  end
end
