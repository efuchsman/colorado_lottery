class ColoradoLottery

  attr_reader :winners, :current_contestants, :registered_contestants

  def initialize
    @winners = []
    @current_contestants = {}
    @registered_contestants = Hash.new
  end



  def interested_and_18?(contestant, game)
    @contestant = contestant
    @game = game

    if contestant.age >= 18 && contestant.game_interests.include?(game.name)
      true
    else
      false
    end
  end

  def can_register?(contestant, game)
    @game = game
    @contestant = contestant
    if interested_and_18?(contestant, game) != true
      return false
    end
    if @game.national_drawing? == false && contestant.state_of_residence != "CO"
      return false
    end
    true
  end

  def register_contestant(contestant, game)
    if can_register?(contestant, game) && @registered_contestants[game.name]
      @registered_contestants[game.name] << contestant
    else
      @registered_contestants[game.name] = [contestant]
    end
    @registered_contestants
  end

end
