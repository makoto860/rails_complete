class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to @reservation, notice: "予約を完了しました"
    else
      @product = @reservation.product
      render :confirmation, status: :unprocessable_entity
    end
  end

  def confirmation
    @product = Product.find(params[:reservation][:product_id])
    @reservation = @product.reservations.new(reservation_params)
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    redirect_to reservations_path, notice: '予約が削除されました。'
  end

  private
   def reservation_params
     params.require(:reservation).permit(:start_date, :end_date, :total_people, :total_day, :total_amount, :product_id, :user_id)
   end
end
