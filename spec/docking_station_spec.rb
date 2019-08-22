require 'docking_station'

describe DockingStation do

  let (:ds) { DockingStation.new(10, 10) }

  it { should respond_to(:release_bike)}
  it { should respond_to(:dock)}
  it { should respond_to(:bikes)}

  it "accepts a capacity argument" do
    expect(ds.capacity).to eq(10)
  end

  it "defaults to a capacity of 20 when none is set" do
    expect(subject.capacity).to eq(20)
  end

  context "full station" do
    let (:full_station) { DockingStation.new(20,20) }

    it "raises an error when attempting to dock a full station" do
      bike = Bike.new
      expect {full_station.dock(bike)}.to raise_error(ArgumentError)
    end

    it 'releases a bike' do
      expect(full_station.release_bike).to be_instance_of(Bike)
    end

    it 'displays the bikes that are docked' do
      expect(full_station.bikes.length).to eq(20)
    end
  end

  context "empty station" do
    let (:empty_station) { DockingStation.new(20)}

    it 'raises error when no bikes are present' do
      expect {empty_station.release_bike}.to raise_error(ArgumentError)
    end

    it 'docks a bike' do
      bike = Bike.new
      empty_station.dock(bike)
      expect(empty_station.bikes).to include(bike)
    end

    it "reports a broken bike when docking" do
      bike = Bike.new
      empty_station.dock(bike, 'report')
      expect(bike.working?).to_not eq(true)
    end

    it "doesn't release a broken bike" do
      bike = Bike.new.report_broken
      empty_station.dock(bike)
      expect {empty_station.release_bike}.to raise_error(NoMethodError)
    end
  end
end
