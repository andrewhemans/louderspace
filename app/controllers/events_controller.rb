class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.includes(:venue, :genres)
  
    if params[:city].present? && params[:state].present?
      location = "#{params[:city]}, #{params[:state]}"
      city_coordinates = Geocoder.coordinates(location)
      
      if city_coordinates
        distance = params[:distance].present? ? params[:distance].to_i : 10 # Default distance
        # First, get nearby venues without ordering by distance
        nearby_venues = Venue.near(city_coordinates, distance, order: false)
        # Then pluck their IDs
        nearby_venue_ids = nearby_venues.pluck(:id)
        @events = @events.joins(:venue).where(venues: { id: nearby_venue_ids })
      end
    end
  
    if params[:genre_id].present?
      @events = @events.joins(:genres).where(genres: { id: params[:genre_id] })
    end
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :date, :time, :description, :venue_id, genre_ids: [])
    end
end
