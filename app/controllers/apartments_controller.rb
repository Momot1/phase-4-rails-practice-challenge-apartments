class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

    def index
        render json: Apartment.all
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        render json: apartment
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: {error: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def destroy
        Apartment.find(params[:id]).destroy
        render json: {}
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def rescue_record_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end
end
