require 'rails_helper'

RSpec.describe VotesController, :type => :controller do
  let(:token) { SecureRandom.hex }
  let(:author) { User.create(email: 'jack@test.com')}
  let(:user) { User.create(
    token: token,
    uid:  'null|67890',
    name: 'Bob',
    email: 'bob@test.com',
  )}
  let(:movie) { Movie.create(user: author) }

  before do
    session[:token] = token
    Ability.new(user)
  end

  describe "GET create" do
    it "is successful and redirects" do
      expect(Movie[movie.id].liker_count.to_i).to eq(0)
      get :create, movie_id: movie.id, t: "like"
      expect(response).to have_http_status(:redirect)
      expect(Movie[movie.id].liker_count.to_i).to eq(1)
    end
  end

  describe "GET destroy" do
    before do
      post :create, movie_id: movie.id, t: "like"
    end

    it "returns http success" do
      expect(Movie[movie.id].liker_count.to_i).to eq(1)
      get :destroy, movie_id: movie.id
      expect(response).to have_http_status(:redirect)
      expect(Movie[movie.id].liker_count.to_i).to eq(0)
    end
  end
end
