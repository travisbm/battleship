class GamesController < ApplicationController
  respond_to :html, :json, :js

  def new
  end

  def create
    game = Game.create

    redirect_to game_path(game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def fire
    @game = Game.find(params[:id])

    @game.fire(params[:cell_id])
    @cell = Cell.find(params[:cell_id])

    respond_to do |format|
      format.html {redirect_to :game}
      format.js
    end

    # begin
    #   game.fire(params[:cell_id])
    # rescue
    #   flash[:notice] = "Invalid Cell Status."
    # end
    #
    # redirect_to new_user_session_path and return if game.game_over?
    #
    # redirect_to game_path(game)
  end

end
