require 'rails_helper'

RSpec.describe MoviesController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  context "logged in" do
    let(:token) { SecureRandom.hex }
    let(:user) { User.create(token: token) }
    movie_data = {
      title:        'Teenage mutant nija turtles',
      description:  'Technically, we\'re turtles.',
      date:         '2014-10-17'
    }

    before do
      session[:token] = token
      Ability.new(user)
    end

    describe "GET new" do
      it "returns http success" do
        get :new, movie_data
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST create" do
      it "returns http success" do
        post :create, movie_data
        expect(response).to have_http_status(:found)
      end
    end
  end
end
