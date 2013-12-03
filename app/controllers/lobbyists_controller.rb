class LobbyistsController < ApplicationController
  before_action :set_lobbyist, only: [:show, :edit, :update, :destroy]

  # GET /lobbyists
  # GET /lobbyists.json
  def index
    @lobbyists = Lobbyist.all
  end

  # GET /lobbyists/1
  # GET /lobbyists/1.json
  def show
    Lobbyist.call_team_payments
    Lobbyist.call_my_payments
  end

  # GET /lobbyists/new
  def new
    @lobbyist = Lobbyist.new
  end

  # GET /lobbyists/1/edit
  def edit
  end

  # POST /lobbyists
  # POST /lobbyists.json
  def create
    @lobbyist = Lobbyist.new(lobbyist_params)

    respond_to do |format|
      if @lobbyist.save
        format.html { redirect_to @lobbyist, notice: 'Lobbyist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lobbyist }
      else
        format.html { render action: 'new' }
        format.json { render json: @lobbyist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lobbyists/1
  # PATCH/PUT /lobbyists/1.json
  def update
    respond_to do |format|
      if @lobbyist.update(lobbyist_params)
        format.html { redirect_to @lobbyist, notice: 'Lobbyist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lobbyist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lobbyists/1
  # DELETE /lobbyists/1.json
  def destroy
    @lobbyist.destroy
    respond_to do |format|
      format.html { redirect_to lobbyists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lobbyist
      @lobbyist = Lobbyist.find_by(slug: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lobbyist_params
      params.require(:lobbyist).permit(:name, :firm_id)
    end
end
