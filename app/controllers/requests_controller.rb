class RequestsController < ApplicationController
  skip_before_action :authorized, except: [:index]

  def index
    @request = Request.all
    render json: @request, status: 200
  end

  def show
    if !params[:id].match(/\D/) && logged_in?
      @request = Request.find params[:id]
    else
      @request = Request.find_by reference_number: params[:id]
    end
    head 404 and return if @request == nil
    render json: @request, status: 200
  end

  def create
    @request = Request.new(request_params)
    @request.dates = parse_dates params[:request][:dates]
    @request.reference_number = generate_reference_number
    if @request.save!
      render json: @request, status: 201
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  def update
    if !params[:id].match(/\D/) && logged_in?
      @request = Request.find params[:id]
    else
      @request = Request.find_by reference_number: params[:id]
    end
    head 404 and return if @request == nil
    @request.dates = parse_dates(params[:request][:dates]) if params[:request][:dates]

    head 204 and return if @request.update(request_params)
    render json: @request.errors, status: :unprocessable_entity
  end

  def delete
    begin
      if !params[:id].match(/\D/) && logged_in?
        @request = Request.find params[:id]
      else
        @request = Request.find_by reference_number: params[:id]
      end
    rescue
      head 404 and return
    end

    head 204 and return if @request.destroy!

    render json: @request.errors
  end

  private

  def generate_reference_number
    char_array = (0..9).to_a + ("A".."Z").to_a
    ref_number = char_array.sample(6).join
  end

  def request_params
    params.require(:request).permit(:first_name, :last_name, :email_address, :phone_number, :num_adults, :num_children, :num_dogs, :dates, :reference_number)
  end
end
