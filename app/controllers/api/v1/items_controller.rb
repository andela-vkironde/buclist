module API
  module V1
    class ItemsController < ApplicationController
      before_action :set_bucketlist_item, only: [:show, :update, :destroy]
      before_action :bucketlist_items, only: [:index, :create]

      def index
        json_response(paginate_items)
      end

      def create
        new_item = @items.new(list_params)
        new_item.save!
        json_response(new_item, :created)
      end

      def update
        @item.update!(list_params)
        json_response(@item)
      end

      def show
        json_response(@item)
      end

      def destroy
        @item.destroy
        json_response(message: Messages.deleted("item"))
      end

      private

      def list_params
        params.permit(:name, :bucketlist_id, :done)
      end

      def paginate_items
        @items.paginate(params[:limit], params[:page]) if @items
      end
    end
  end
end
