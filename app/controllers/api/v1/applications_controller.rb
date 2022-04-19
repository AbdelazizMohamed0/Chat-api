# frozen_string_literal: true

module Api
  module V1
    class ApplicationsController < ApplicationController
      def index
        @apps = App.all
        render json: @apps
      end

      def show
        @apps = App.find_by(app_no: params[:app_no])
        render json: @apps
      end

      def create
        @apps = App.new(app_params)
        @apps.chat_count
        if @App.save
          render json: @apps, status: :created

        else
          render json: @apps.error, status: :unprocessable_entit

        end
      end

      def update
        @apps = App.find_by(app_no: params[:app_no])

        if @apps.update(app_params)
          render json: @apps, status: :created
        else
          render json: apps, status: :unprocessable_entity
        end
      end

      def destroy
        @apps = App.find_by(app_no: params[:app_no])
        if @apps.destroy
          head :no_content
        else
          render json: apps.error, status: :unprocessable_entity
        end
      end

      def app_params
        params.require(:apps).permit(:app_name)
      end
    end
  end
end
