class Clause
  def initialize(number, capitalize = false)
    @capitalize = capitalize
    @number = number
  end

  private

  attr_reader :capitalize, :number

  def normalize_number
    result = number.zero? ? 'no more' : number
    capitalize ? result.to_s.capitalize : result
  end

  def pluralize_bottles
    (number == 1) ? 'bottle' : 'bottles'
  end
end

class ObservationClause < Clause
  def to_s
    "#{normalize_number} #{pluralize_bottles} of beer on the wall"
  end
end

class ShortObservationClause < Clause
  def to_s
    "#{normalize_number} #{pluralize_bottles} of beer"
  end
end

class ActionClause < Clause
  def to_s
    if number.zero?
      'Go to the store and buy some more'
    else
      "Take #{pluralize_count} down and pass it around"
    end
  end

  private

  def pluralize_count
    (number == 1) ? 'it' : 'one'
  end
end

class Sentence
  def initialize(clause1, clause2)
    @clause1 = clause1
    @clause2 = clause2
  end

  def to_s
    "#{clause1}, #{clause2}."
  end

  private

  attr_reader :clause1, :clause2
end

class Bottles
  def verse(number)
    action_clause            = ActionClause.new(number)
    new_observation_clause   = ObservationClause.new(new_number(number))
    observation_clause       = ObservationClause.new(number, true)
    short_observation_clause = ShortObservationClause.new(number)

    sentence1 = Sentence.new(observation_clause, short_observation_clause)
    sentence2 = Sentence.new(action_clause, new_observation_clause)

    "#{sentence1}\n#{sentence2}\n"
  end

  def verses(top_number, bottom_number = nil)
    bottom_number = bottom_number.nil? ? top_number : bottom_number
    numbers = (bottom_number..top_number).to_a.reverse
    numbers.map { |number| verse(number) }.join("\n")
  end

  def song
    verses(99, 0)
  end

  private

  def new_number(number)
    result = number - 1
    (result < 0) ? 99 : result
  end
end
