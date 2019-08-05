class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :udate, :destroy]

  def index
    @pins = Pin.all
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
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

  def correct_user
    @pin = current_user.pins.find_by(id: params[:id])
    redirect_to pins_path, notice: "You are not authorized to edit this pin" if @pin.nil?
  end
end
