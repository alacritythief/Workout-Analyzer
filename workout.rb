# Define a Workout class that encapsulates the necessary data and the methods that calculate this information.

class Workout
  attr_reader :workouts, :exercises, :id, :calories_calc, :burned

  def initialize(file = 'workouts.csv')
    @workouts = load_workout_data(file)
  end

  def pick(choice = 1)
    @pick = @workouts[choice]
    @id = choice
    return @pick
  end

  def count_workouts
    return @workouts.count
  end

  def type
    @exercises = []

    @pick[:exercises].each do |exercise|
      @exercises << exercise[:category]
    end

    strength = @exercises.grep("strength").size
    cardio = @exercises.grep("cardio").size

    if strength > cardio
      type = "strength"
    elsif cardio > strength
      type = "cardio"
    else
      type = "other"
    end

    return type
  end

  def date
    @date = @pick[:date]
    @date = Date.strptime(@date, '%m/%d/%y').to_s
  end

  def sum(array)
    sum = 0
    array.each do |time|
      sum = sum + time.to_f
    end
    return sum
  end

  def duration
    @duration = []
    @pick[:exercises].each do |exercise|
      @duration << exercise[:duration_in_min]
    end
    @duration = sum(@duration)
    return @duration
  end

  def calories_calc(exercises)
    burned = []

    exercises.each do |category, duration, intensity|
      if category == "cardio"
        if intensity == "high"
          burned << duration * 10
        elsif intensity == "medium"
          burned << duration * 8
        elsif intensity == "low"
          burned << duration * 5
        else
          burned << duration * 6
        end
      else
        burned << duration * 6
      end
    end

    return burned
  end


  def calories_burned

    @exercises = []
    @total_burned = []

    @pick[:exercises].each do |exercise|
      @exercises << [exercise[:category], exercise[:duration_in_min], exercise[:intensity]]
    end

    @burned = calories_calc(@exercises)
    @total_burned = sum(@burned)

    return @total_burned
  end

end


