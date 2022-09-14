require 'rspec'
require './lib/game'
require './lib/contestant'

RSpec.describe Contestant do
  it 'exists' do

alexander = Contestant.new(
  {
    first_name: 'Alexander',
    last_name: 'Aigiades',
    age: 28,
    state_of_residence: 'CO',
    pending_money: 10
    })

    expect(alexander).to be_an_instance_of(Contestant)
  end

  it 'has readable attributes' do
    alexander = Contestant.new(
      {
        first_name: 'Alexander',
        last_name: 'Aigiades',
        age: 28,
        state_of_residence: 'CO',
        pending_money: 10
        })


    expect(alexander.full_name).to eq("Alexander Aigiades")
    expect(alexander.age).to eq(28)
    expect(alexander.state_of_residence).to eq("CO")
    expect(alexander.spending_money).to eq(10)
    expect(alexander.out_of_state?).to be false
    expect(alexander.game_interests).to eq([])

  end

  it "can add games of interest" do
    alexander = Contestant.new(
      {
        first_name: 'Alexander',
        last_name: 'Aigiades',
        age: 28,
        state_of_residence: 'CO',
        pending_money: 10
        })

        alexander.add_game_interest('Mega Millions')
        alexander.add_game_interest('Pick 4')

        expect(alexander.game_interests).to eq(["Mega Millions", "Pick 4"])


  end

end
