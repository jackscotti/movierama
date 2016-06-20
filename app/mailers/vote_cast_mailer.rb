class VoteCastMailer < ActionMailer::Base
  default from: "donotreply@movierama.com"

  def action_email(voter_id, movie_id, action)
    @voter = User[voter_id]
    @movie = Movie[movie_id]
    @recipient = @movie.user
    @action = action

    mail(
      charset:       "utf-8",
      content_type:  "text/html",
      to:            @recipient.email,
      subject:       "Movierama - #{@voter.name} has left a vote on your review",
    )
  end
end
