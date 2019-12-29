class LayersController < ApplicationController
  before_action :set_layer, only: [:show, :edit, :update, :destroy]

  protect_from_forgery except: :show

  require 'color-generator'

  # GET /layers
  # GET /layers.json
  def index
    @map = Map.by_user(current_user).find(params[:map_id])
    @layers = @map.layers
  end

  # GET /layers/1
  # GET /layers/1.json
  def show
    @maps = Map.by_user(current_user)
    @map_layers = @map.layers
    @places = @layer.places
    if params[:remap]
      @place = Place.find(params[:place_id])
    end
    respond_to do |format|
      format.html { render :show }
      # format.json { render json: @layer.to_json
      # (:include =>
      # { :places => { :methods => [:date, :edit_link], :include => :images }} ) }
      # switch to json.builder
      format.json { render :show }
    end
  end

  # GET /layers/new
  def new
    @layer = Layer.new
    generator = ColorGenerator.new saturation: 0.7, lightness: 0.75
    @layer.color = '#' + generator.create_hex
    @map = Map.by_user(current_user).find(params[:map_id])
    @colors_selectable = []
    6.times do
      @colors_selectable << '#' + generator.create_hex
    end
  end

  # GET /layers/1/edit
  def edit
    generator = ColorGenerator.new saturation: 0.7, lightness: 0.75
    if !@layer.color || params[:recolor]
      @layer.color = '#' + generator.create_hex
    elsif @layer.color && !@layer.color.include?('#')
      @layer.color = '#' + @layer.color
    end

    @colors_selectable = []
    6.times do
      @colors_selectable << '#' + generator.create_hex
    end
  end

  # POST /layers
  # POST /layers.json
  def create
    @layer = Layer.new(layer_params)
    if @layer.color && !@layer.color.include?('#')
      @layer.color = '#' + @layer.color
    end
    @map = Map.by_user(current_user).find(params[:map_id])
    respond_to do |format|
      if @layer.save
        format.html { redirect_to map_path(@map), notice: 'Layer was created.' }
        format.json { render :show, status: :created, location: @layer }
      else
        format.html { render :new }
        format.json { render json: @layer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /layers/1
  # PATCH/PUT /layers/1.json
  def update
    if @layer.color && !@layer.color.include?('#')
      @layer.color = '#' + @layer.color
    end
    respond_to do |format|
      if @layer.update(layer_params)
        format.html { redirect_to map_path(@map), notice: 'Layer was successfully updated.' }
        format.json { render :show, status: :ok, location: @layer }
      else
        format.html { render :edit }
        format.json { render json: @layer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /layers/1
  # DELETE /layers/1.json
  def destroy
    @layer.destroy
    respond_to do |format|
      format.html { redirect_to map_path(@map), notice: 'Layer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_layer
    @map = Map.by_user(current_user).find(params[:map_id])
    @layer = Layer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def layer_params
    params.require(:layer).permit(:title, :text, :published, :map_id, :color)
  end
end
