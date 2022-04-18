class LeaseController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: created
    rescue ActiveRecord::RecordInvalid => e
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def destroy
        Lease.find(params[:id]).destroy
        render json: {}
    end

    private

    def lease_params
        params.permit(:rent)
    end

    def rescue_record_not_found
        render json: {error: "Lease not fouund"}, status: :not_found
    end
end
