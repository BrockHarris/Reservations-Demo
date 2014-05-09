require 'spec_helper'

describe Reservation do
  before do
    @reservation = Reservation.new(time: '6', date: '2014-04-28', guests: '2', name: 'Jim Jones')
  end

  subject { @reservation }

  it { should respond_to(:time) }
  it { should respond_to(:date) }
  it { should respond_to(:guests) }
  it { should respond_to(:name) }

  it { should be_valid }

  describe "when time is invalid" do
    before { @reservation.time = '2' }
    it { should_not be_valid }
  end

  describe "when number of guests is invalid" do
    before { @reservation.guests = '5' }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @reservation.name = '' }
    it { should_not be_valid }
  end

  describe "when name is too short" do
    before { @reservation.name = 'ab' }
    it { should_not be_valid }
  end

  describe "when there is not a time conflict" do
    before { Reservation.create!(time: '8', date: '2014-04-28', guests: '2', name: 'Jim Jones')}
    it { should be_valid }
  end

  describe "when there is a time overlap" do
    before { Reservation.create!(time: '5', date: '2014-04-28', guests: '2', name: 'Jim Jones')}
    it { should_not be_valid }
  end

  describe "when there is a time overlap" do
    before { Reservation.create!(time: '7', date: '2014-04-28', guests: '2', name: 'Jim Jones')}
    it { should_not be_valid }
  end

  describe "when there is a time conflict" do
    before { Reservation.create!(time: '6', date: '2014-04-28', guests: '2', name: 'Jim Jones')}
    it { should_not be_valid }
  end

  describe "when the number of guests prevents a time conflict" do
    before { Reservation.create!(time: '6', date: '2014-04-28', guests: '4', name: 'Jim Jones')}
    it { should be_valid }
  end

  describe "when a different date prevents a time conflict" do
    before { Reservation.create!(time: '6', date: '2014-04-29', guests: '2', name: 'Jim Jones')}
    it { should be_valid }
  end

 
end
