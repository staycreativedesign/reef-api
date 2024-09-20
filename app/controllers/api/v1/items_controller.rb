module Api
  module V1
    class ItemsController < ApplicationController
      before_action :find_store, only: [ :index, :create ]
      before_action :find_item, only: [ :update, :destroy ]

      def index
        @items = @store.items

        raise BlankObjectError unless @items.present?

        render json: @items, status: :ok
      end

      def show
        @item = Item.find(params[:id])

        render json: @item, status: :ok
      end

      def create
        @item = @store.items.create!(item_params)

        render json: @item, status: :created
      end

      def update
        @item.update!(item_params)

        render json: @item, status: :ok
      end

      def destroy
        @item.destroy!

        render json: nil, status: :no_content
      end

      private

      def find_store
        @store = Store.find(params[:store_id])
      end


      def find_item
        @item = Item.find(params[:id])
      end

      def item_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
    end
  end
end
