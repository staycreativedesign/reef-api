module Api
  module V1
    class StoresController < ApplicationController
      before_action :find_store, only: [ :update, :destroy ]

      def index
        @stores = Store.all
        render json: @stores, status: :ok
      end

      def show
        @store = Store.find(params[:id])

        render json: @store, status: :ok
      end

      def create
        @store = Store.create!(store_params)

        render json: @store, status: :created
      end

      def update
        result = @store.update!(store_params)

        render json: @store, status: :ok
      end

      def destroy
        @store.destroy!

        render json: nil, status: :no_content
      end

      private

      def find_store
        @store = Store.find(params[:id])
      end

      def store_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
    end
  end
end
