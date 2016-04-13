require 'rails_helper'

RSpec.describe GamesController, type: :controller do
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
    let(:game) {create(:game)}

    it 'renders show template' do
      get :show, id: game.id
      expect(response).to render_template(:show)
    end

    it 'assigns game to @game' do
      get :show, id: game.id
      expect(assigns[:game]).to eq(game)
    end
  end

end
