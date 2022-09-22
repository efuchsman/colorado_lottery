require 'date'

class ColoradoLottery

  attr_reader :winners, :current_contestants, :registered_contestants

  def initialize
    @winners = []
    @current_contestants = Hash.new {|h, k| h[k] = [] }
    @registered_contestants = Hash.new {|h, k| h[k] = [] }
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
  @registered_contestants[game.name] << contestant if can_register?(contestant, game) == true
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
      @current_contestants[game.name] << contestant
      contestant.spending_money -= game.cost
    end

  end

  # def draw_winners
  #   @current_contestants.each_key do |game|
  #     random_winner = @current_contestants[game].sample
  #     @winners << {random_winner.full_name => game_name}
  #   end
  #   p @winners
  #   Date.today.to_s
  # end


end
