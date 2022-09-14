class ColoradoLottery

  attr_reader :registered_contestants, :winners, :currrrent_contestants

  def initialize
    @registered_contestants = {}
    @winners = []
    @currrrent_contestants = {}
  end

end
