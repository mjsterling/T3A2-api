class RequestsController < ApplicationController

  def index
    @request = Request.all
    render json: @request, status: 200
  end

  def show
    @request = Request.find(params[:id])
    render json: @request, status: 200
  end

  def create
    @request = Request.new(request_params)
    if @request.save!
      render json @request, status: 201
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  def update
    @request = Request.find(params[:id])
    if @request.update(request_params)
      head 204 and return
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  private

  def generate_reference_number
    char_array = (0..9).to_a + ("a".."z").to_a
    ref_number = char_array.sample(10).join
  end

  def request_params
    params.require(:request).permit(:first_name, :last_name, :email_address, :phone_number, :num_adults, :num_children, :num_dogs, :dates, :archived, :reference_number)
  end

end
