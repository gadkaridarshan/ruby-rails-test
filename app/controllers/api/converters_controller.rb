require 'currency_exchange'
require 'date'

class Api::ConvertersController < ApplicationController
  before_action :set_converter, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  # GET /converters
  # GET /converters.json
  def index
    render json: Converter.all
  end

  # GET /converters/1
  # GET /converters/1.json
  def show
    render json: @converter
  end

  # POST /converters
  # POST /converters.json
  def create
    @converter = Converter.new(converter_params)
    year, month, day = @converter.conversion_date.split("-")
    @converter.conversion_rate = CurrencyExchange.rate(Date.new(year.to_i,month.to_i,day.to_i), @converter.from_currency, @converter.to_currency)

    if @converter.save
      render json: @converter, status: :created
    else
      render json: @converter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /converters/1
  # PATCH/PUT /converters/1.json
  def update
    if @converter.update(converter_params)
      render json: @converter
    else
      render json: @converter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /converters/1
  # DELETE /converters/1.json
  def destroy
    @converter.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_converter
      @converter = Converter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def converter_params
      # params.fetch(:converter, {})
      params.require(:converter).permit(:from_currency, :to_currency, :conversion_date)
    end
end
