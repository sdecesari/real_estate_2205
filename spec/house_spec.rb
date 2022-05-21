require './lib/room'
require './lib/house'
require 'pry'

RSpec.describe House do
  let(:house) {House.new("$400000", "123 sugar lane")}
  let(:room_1) {Room.new(:bedroom, 10, '13')}
  let(:room_2) {Room.new(:bedroom, 11, '15')}
  let(:room_3) {Room.new(:living_room, 25, '15')}
  let(:room_4) {Room.new(:basement, 30, '41')}

  it "exists and has attributes" do
    expect(house.price).to eq 400000
    expect(house.address).to eq "123 sugar lane"
    expect(house.rooms).to eq []
  end

  it "#rooms" do
    house.add_room(room_1)
    house.add_room(room_2)

    expect(house.rooms).to eq [room_1, room_2]
  end

  it "#above_market_average" do
    expect(house.above_market_average?).to eq false
  end

  it "#rooms_from_category" do
    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    expect(house.rooms_from_category(:bedroom)).to eq [room_1, room_2]
    expect(house.rooms_from_category(:basement)).to eq [room_4]
  end

  it "#area" do
    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    expect(house.area).to eq 1900
  end

  it "#details" do
    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    expected = {
      "price" => 400000,
      "address" => "123 sugar lane"
    }

    expect(house.details).to eq expected
  end

  it "#price_per_square_foot" do
    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    expect(house.price_per_square_foot).to eq 210.53
  end

  it "#rooms_sorted_by_area" do
    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    expect(house.rooms_sorted_by_area).to eq [room_4, room_3, room_2, room_1]
  end

  it "#rooms_by_category" do
    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)
    expected = {
      :bedroom => [room_1, room_2],
      :living_room => [room_3],
      :basement => [room_4]
    }

    expect(house.rooms_by_category).to eq expected 
  end
end
