require 'csv'
require_relative './team'
require_relative './game'

class Ranker
  attr_accessor :teams

  def initialize(input)
    @input = input
  end

  def parse
    games = []
    teams = {}
    CSV.parse(@input) do |row|
      regex = /\s?(.+) (\d)/
      entries = row.map do |entry|
        match = regex.match(entry)
        name = match[1]
        teams[name] ||= Team.new(name, 0)
        score = match[2].to_i
        [teams[name], score]
      end
      games << Game.new(entries[0][0], # team 1
                        entries[0][1], # score
                        entries[1][0], # team 2
                        entries[1][1]) # score
    end
    @teams = teams.values
    games
  end

  def compute_team_scores(games)
    games.each do |game|
      game.add_scores
    end
  end

  def rank_and_output
    ordered_teams = @teams.sort.reverse
    i = 0
    prev_team = nil
    ranked_teams = []
    while i < ordered_teams.size
      team = ordered_teams[i]
      if i > 0
        prev_team = ordered_teams[i - 1]
      end
      if prev_team && team.score == prev_team.score
        ranked_teams << [ranked_teams[i - 1][0], team]
      else
        ranked_teams << [i + 1, team]
      end
      i += 1
    end

    ranked_teams.map do |entry|
      rank, team = entry
      pt_suffix = team.score == 1 ? '' : 's'
      "#{rank}. #{team.name}, #{team.score} pt#{pt_suffix}"
    end.join("\n") + "\n"
  end

  def rank
    games = parse()
    compute_team_scores(games)
    rank_and_output()
  end
end

