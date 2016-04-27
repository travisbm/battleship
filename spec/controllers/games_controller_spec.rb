require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game_no_shots) {create(:game, :score_no_shots)}
  let(:game)          {create(:game)}
  let(:cell)          {create(:cell)}

  describe 'GET new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    it 'creates a game' do
      expect{ post :create }.to change(Game, :count).by(1)
    end

    it 'redirects to the game' do
      post :create
      expect(response).to redirect_to(Game.last)
    end
  end

  describe 'GET show' do
    it 'renders show template' do
      get :show, id: game.id
      expect(response).to render_template(:show)
    end

    it 'assigns game to @game' do
      get :show, id: game.id
      expect(assigns[:game]).to eq(game)
    end
  end

  describe 'PUT fire' do
    it 'redirects to sign in if game is over' do
      get :fire, id: game_no_shots.id, cell_id: cell.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirects to game_path if game is not over' do
      get :fire, id: game.id, cell_id: cell.id
      expect(response).to redirect_to(game_path(game))
    end
  end

end
