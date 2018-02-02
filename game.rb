class Game
  attr_accessor :team1
  attr_accessor :team1_score

  attr_accessor :team2
  attr_accessor :team2_score

  def initialize(team1, team1_score, team2, team2_score)
    @team1 = team1
    @team1_score = team1_score
    @team2 = team2
    @team2_score = team2_score
  end

  def add_scores
    team1.score += score_for(team1)
    team2.score += score_for(team2)
  end

  # Not to be confused with the raw score, this is
  # the calculated score based on who won.
  def score_for(team)
    if team == team1
      a = team1_score
      b = team2_score
    elsif team == team2
      a = team2_score
      b = team1_score
    else
      raise "Invalid team provided"
    end
    a > b ? 3 : (a == b) ? 1 : 0
  end
end