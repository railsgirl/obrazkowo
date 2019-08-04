class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy]

  def index
    @pins = Pin.all
  end

  def show
  end

  def new
    @pin = Pin.new
  end

  def edit
  end

  def create
    @pin = Pin.new(pin_params)
    if @pin.save
      redirect_to @pin, notice: "The pin was created"
    else
      render 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Update successful"
    else
      render 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_path, notice: "Pin destroyed"
  end

  private

  def pin_params
    params.require(:pin).permit(:description)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end

end
