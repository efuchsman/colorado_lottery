require 'date'

class ColoradoLottery

  attr_reader :winners, :current_contestants, :registered_contestants

  def initialize
    @winners = []
    @current_contestants = {}
    @registered_contestants = {}
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
    if interested_and_18?(contestant, game) != true
      return false
    end
    if @game.national_drawing? == false && contestant.state_of_residence != "CO"
      return false
    end
    true
  end

  def register_contestant(contestant, game)
    if can_register?(contestant, game)
      if @registered_contestants[game.name]
        @registered_contestants[game.name] << contestant
      else
        @registered_contestants[game.name] = [contestant]
      end
    end
  end

  def eligible_contestants(game)
    eligible = []
    contestants = @registered_contestants[game.name]
    contestants.each do |contestant|
      eligible << contestant if contestant.spending_money >= game.cost
    end
    eligible
  end

  def charge_contestants(game)
    eligible_contestants(game).each do |contestant|
      contestant.spending_money -= game.cost
      if @current_contestants[game.name]
        @current_contestants[game.name] << contestant
      else
        @current_contestants[game.name] = [contestant]
      end
    end
  end

  def draw_winners
    @current_contestants.each_key do |game|
      random_winner = @current_contestants[game].sample
      @winners << {random_winner.full_name => game}
    end
    p @winners
    Date.today.to_s
  end


end
