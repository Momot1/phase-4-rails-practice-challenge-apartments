class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

    def index
        render json: Tenant.all
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update(tenant_params)
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def destroy
        Tenant.find(params[:id]).destroy
        render json: {}
    end

    private

    def rescue_record_not_found
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def tenant_params
        params.permit(:name, :age)
    end
end
