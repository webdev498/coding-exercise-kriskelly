require 'rspec'
require_relative './ranker'

describe Ranker do
  before do
    @input = File.read('./sample-input.txt')
    @ranker = Ranker.new(@input)
    @expected_output = File.read('./expected-output.txt')
  end

  it 'should parse the input file into a set of teams and games' do
    games = @ranker.parse
    expect(@ranker.teams.size).to eq(5)
    expect(games.size).to eq(5)
    expect(games.first.team1.name).to eq('Lions')
    expect(games.first.team2.name).to eq('Snakes')
  end

  it 'should calculate the score for each team' do
    team1 = Team.new('Foo', 0)
    team2 = Team.new('Bar', 0)
    games = [
      Game.new(team1, 3, team2, 3),
      Game.new(team1, 0, team2, 1),
      Game.new(team1, 0, team2, 2),
    ]
    @ranker.teams = [team1, team2]
    @ranker.compute_team_scores(games)
    expect(@ranker.teams.first.name).to eq('Foo')
    expect(@ranker.teams.first.score).to eq(1)
    expect(@ranker.teams[1].name).to eq('Bar')
    expect(@ranker.teams[1].score).to eq(7)
  end

  it 'should sort the list of teams by score and return a formatted list' do
    @ranker.teams = [
      Team.new("Foo", 4),
      Team.new("Bar", 1),
      Team.new("Baz", 5),
      Team.new("Quux", 1),
    ]
    expect(@ranker.rank_and_output()).to eq("1. Baz, 5 pts
2. Foo, 4 pts
3. Bar, 1 pt
3. Quux, 1 pt
")
  end

  it 'should take input and return the correct output' do
    expect(@ranker.rank).to eq(@expected_output)
  end
end