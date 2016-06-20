require 'rails_helper'

RSpec.describe VotingBooth, :type => :service do
  let(:voter) { User.create(
    uid:  'null|12345',
    name: 'Alice'
  )}
  let(:author) { User.create(
    uid:  'null|67890',
    name: 'Bob',
    email: 'bob@test.com'
  )}
  let(:movie) { Movie.create(
    title:        'Empire strikes back',
    description:  'Who\'s scruffy-looking?',
    date:         '1980-05-21',
    user:         author,
    liker_count:  50,
    hater_count:  2
  )}

  before do
    ActionMailer::Base.deliveries = []
  end

  describe "voting" do
    it "sends an email when someone votes" do
      vote = :like
      booth = VotingBooth.new(voter, movie)

      expect(ActionMailer::Base.deliveries.empty?).to eq(true)
      booth.vote(vote)
      expect(ActionMailer::Base.deliveries.empty?).to eq(false)

      sent_email = ActionMailer::Base.deliveries.first
      expect(sent_email.to).to include(author.email)
      expect(sent_email.body.encoded).to include(vote.to_s)
      expect(sent_email.subject).to include(voter.name)
    end
  end
end
