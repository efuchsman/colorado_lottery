require 'rspec'
require './lib/game'
require './lib/contestant'
require './lib/colorado_lottery'
require 'date'

RSpec.describe ColoradoLottery do
  it 'exists' do
    lottery = ColoradoLottery.new

    expect(lottery).to be_an_instance_of(ColoradoLottery)
  end

  it 'has no contestants or winners yet' do
    lottery = ColoradoLottery.new

    expect(lottery.registered_contestants).to eq({})
    expect(lottery.winners).to eq([])
    expect(lottery.current_contestants).to eq({})
  end

  it 'has games and contestants' do

    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)

    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10})

      benjamin = Contestant.new({
        first_name: 'Benjamin',
        last_name: 'Franklin',
        age: 17,
        state_of_residence: 'PA',
        spending_money: 100})

        frederick = Contestant.new({
          first_name:  'Frederick',
          last_name: 'Douglass',
          age: 55,
          state_of_residence: 'NY',
          spending_money: 20})

          winston = Contestant.new({
            first_name: 'Winston',
            last_name: 'Churchill',
            age: 18,
            state_of_residence: 'CO',
            spending_money: 5})

            alexander.add_game_interest('Pick 4')
            alexander.add_game_interest('Mega Millions')
            frederick.add_game_interest('Mega Millions')
            winston.add_game_interest('Cash 5')
            winston.add_game_interest('Mega Millions')
            benjamin.add_game_interest('Mega Millions')

            lottery.interested_and_18?(alexander, pick_4)
            lottery.interested_and_18?(benjamin, mega_millions)
            lottery.interested_and_18?(alexander, cash_5)

            expect(lottery.interested_and_18?(alexander,pick_4)).to be true
            expect(lottery.interested_and_18?(benjamin, mega_millions)).to be false
            expect(lottery.interested_and_18?(alexander, cash_5)).to be false
  end

  it 'checks if a contestant can register for the lottery' do
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)

    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10})

      benjamin = Contestant.new({
        first_name: 'Benjamin',
        last_name: 'Franklin',
        age: 17,
        state_of_residence: 'PA',
        spending_money: 100})

        frederick = Contestant.new({
          first_name:  'Frederick',
          last_name: 'Douglass',
          age: 55,
          state_of_residence: 'NY',
          spending_money: 20})

          winston = Contestant.new({
            first_name: 'Winston',
            last_name: 'Churchill',
            age: 18,
            state_of_residence: 'CO',
            spending_money: 5})

            alexander.add_game_interest('Pick 4')
            alexander.add_game_interest('Mega Millions')
            frederick.add_game_interest('Mega Millions')
            winston.add_game_interest('Cash 5')
            winston.add_game_interest('Mega Millions')
            benjamin.add_game_interest('Mega Millions')

            lottery.interested_and_18?(alexander, pick_4)
            lottery.interested_and_18?(benjamin, mega_millions)
            lottery.interested_and_18?(alexander, cash_5)

            lottery.can_register?(alexander, pick_4)
            lottery.can_register?(alexander, cash_5)
            lottery.can_register?(frederick, mega_millions)
            lottery.can_register?(benjamin, mega_millions)
            lottery.can_register?(frederick, cash_5)

            expect(lottery.can_register?(alexander, pick_4)).to be true
            expect(lottery.can_register?(alexander, cash_5)).to be false
            expect(lottery.can_register?(frederick, mega_millions)).to be true
            expect(lottery.can_register?(benjamin, mega_millions)).to be false
            expect(lottery.can_register?(frederick, cash_5)).to be false
  end

  it "registers contestants" do
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)

    alexander = Contestant.new(
      {  first_name: 'Alexander',
        last_name: 'Aigades',
        age: 28,
        state_of_residence: 'CO',
        spending_money: 10 }
    )

    benjamin = Contestant.new({
      first_name: 'Benjamin',
      last_name: 'Franklin',
      age: 17,
      state_of_residence: 'PA',
      spending_money: 100})

    frederick = Contestant.new({
      first_name:  'Frederick',
      last_name: 'Douglass',
      age: 55,
      state_of_residence: 'NY',
      spending_money: 20})

    winston = Contestant.new({
      first_name: 'Winston',
      last_name: 'Churchill',
      age: 18,
      state_of_residence: 'CO',
      spending_money: 5})

    grace = Contestant.new({
      first_name: 'Grace',
      last_name: 'Hopper',
      age: 20,
      state_of_residence: 'CO',
      spending_money: 20})

    alexander.add_game_interest('Pick 4')
    alexander.add_game_interest('Mega Millions')
    frederick.add_game_interest('Mega Millions')
    winston.add_game_interest('Cash 5')
    winston.add_game_interest('Mega Millions')
    benjamin.add_game_interest('Mega Millions')
    grace.add_game_interest('Mega Millions')
    grace.add_game_interest('Cash 5')
    grace.add_game_interest('Pick 4')

    lottery.register_contestant(alexander, pick_4)
    lottery.register_contestant(alexander, mega_millions)
    lottery.register_contestant(frederick, mega_millions)
    lottery.register_contestant(winston, cash_5)
    lottery.register_contestant(winston, mega_millions)
    lottery.register_contestant(grace, mega_millions)
    lottery.register_contestant(grace, cash_5)
    lottery.register_contestant(grace, pick_4)

    expect(lottery.registered_contestants).to eq({
      "Pick 4" => [alexander,grace],
      "Mega Millions" => [alexander, frederick, winston, grace],
      "Cash 5" => [winston, grace]
    })

    expect(lottery.eligible_contestants(pick_4)).to eq([alexander, grace])
    expect(lottery.eligible_contestants(cash_5)).to eq([winston, grace])
    expect(lottery.eligible_contestants(mega_millions)).to eq([alexander, frederick, winston, grace])

     lottery.charge_contestants(cash_5)
     lottery.charge_contestants(mega_millions)
     lottery.charge_contestants(pick_4)


    #  expect(grace.spending_money).to eq(19)
    #  expect(winston.spending_money).to eq(4)

    #  expect(lottery.current_contestants).to eq({"Cash 5" => [winston, grace]})

     expect(lottery.draw_winners).to eq(Date.today.to_s)
  end

end

