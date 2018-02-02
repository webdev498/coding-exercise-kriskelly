class Team
  include Comparable

  attr_accessor :name
  attr_accessor :score

  def initialize(name, score)
    @name = name
    @score = score
  end

  def <=>(other)
    if score == other.score
      other.name <=> name # Alpha sort
    else
      score <=> other.score
    end
  end
end