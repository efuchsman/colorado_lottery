require 'rspec'
require './lib/game'
require './lib/contestant'
require './lib/colorado_lottery'


RSpec.describe ColoradoLottery do
  it 'exists' do
    lottery = ColoradoLottery.new

    expect(lottery).to be_an_instance_of(ColoradoLottery)
  end

  it 'has no contestants or winners yet' do
    lottery = ColoradoLottery.new

    expect(lottery.registered_contestants).to eq({})
    expect(lottery.winners).to eq([])
    expect(lottery.currrrent_contestants).to eq({})
  end

end

