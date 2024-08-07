module Api
  module V1
    class CustomersController < ApplicationController
      def invite
        if params[:file].nil?
          render json: { error: 'File not provided' }, status: :bad_request
          return
        end

        begin
          service = InviteCustomersService.new(params[:file])
          customers = service.call
        rescue StandardError => e
          logger.error "Error inviting customers: #{e.message}"
          render json: { error: 'Internal server error' }, status: :internal_server_error
          return
        end

        render json: customers.map { |customer| { user_id: customer['user_id'], name: customer['name'] } }
      end
    end
  end
end