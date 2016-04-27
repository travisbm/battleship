class GamesController < ApplicationController

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
    game = Game.find(params[:id])

    begin
      game.fire(params[:cell_id])
    rescue
      flash[:notice] = "Invalid Cell Status."
    end

    if game.game_over?
      redirect_to new_user_session_path
    else
      redirect_to game_path(game)
    end
  end

end
