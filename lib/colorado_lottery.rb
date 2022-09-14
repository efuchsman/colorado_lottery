class ColoradoLottery

  attr_reader :registered_contestants, :winners, :currrrent_contestants

  def initialize
    @registered_contestants = {}
    @winners = []
    @currrrent_contestants = {}
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


end
