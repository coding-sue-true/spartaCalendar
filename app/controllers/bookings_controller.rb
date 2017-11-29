class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @rooms = Room.all
    @selected_date = DateTime.now
    @bookings = Booking.where(:start_time => @selected_date.beginning_of_day..@selected_date.end_of_day)
    @date_string = @selected_date.tomorrow
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    @bookings = Booking.all
    @rooms = Room.all
  end

  def next
    @next_date = params[:next_date]
    @next_date = DateTime.parse(@next_date)
    @bookings = Booking.where(:start_time => @next_date.beginning_of_day..@next_date.end_of_day)
    @next_date = @next_date.tomorrow
  end

  # GET /bookings/new
  def new
    @rooms = Room.all
    @booking = Booking.new
    @users = User.all
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to bookings_path, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:start_time, :finish_time, :description, :room_id, :room_name)
    end
end
