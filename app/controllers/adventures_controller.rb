class AdventuresController < ApplicationController
  before_action :set_adventure, only: [:show, :edit, :update, :destroy]

  # GET /adventures
  # GET /adventures.json
  def index
    @adventures = Adventure.all
  end

  # GET /adventures/1
  # GET /adventures/1.json
  def show
  end

  # GET /adventures/new
  def new
    @adventure = Adventure.new
  end

  # GET /adventures/1/edit
  def edit
  end

  # POST /adventures
  # POST /adventures.json
  def create
    
    @adventure = Adventure.new(adventure_params.except("picture_url"))
    if adventure_params["picture_url"]
      @adventure.remote_picture_url = adventure_params["picture_url"]
    end

    respond_to do |format|
      if @adventure.save
        format.html { redirect_to @adventure, notice: 'Adventure was successfully created.' }
        format.json { render :show, status: :created, location: @adventure }
      else
        format.html { render :new }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adventures/1
  # PATCH/PUT /adventures/1.json
  def update
    respond_to do |format|
       if adventure_params["remote_picture_url"]
          @adventure.remote_picture_url = adventure_params["remote_picture_url"]
       end

       if @adventure.update(adventure_params.except("remote_picture_url"))

          format.html { redirect_to @adventure, notice: 'Adventure was successfully updated.' }
          format.json { render :show, status: :ok, location: @adventure }
        else
          format.html { render :edit }
          format.json { render json: @adventure.errors, status: :unprocessable_entity }
        end
      end
    end


  # DELETE /adventures/1
  # DELETE /adventures/1.json
  def destroy
    @adventure.destroy
    respond_to do |format|
      format.html { redirect_to adventures_url, notice: 'Adventure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adventure
      @adventure = Adventure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adventure_params
      params.require(:adventure).permit(:name, :description, :picture, :location, :visit, :remote_picture_url)
    end
end
