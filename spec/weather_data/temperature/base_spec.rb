require 'spec_helper'

describe WeatherData::Temperature::Base do
  subject { WeatherData::Temperature::Base.new(10) }

  shared_examples_for "returning new instance" do
    it do
      expect(subject.send(method_name, subject)).not_to eql subject
    end
  end

  describe "#+" do
    it_should_behave_like "returning new instance" do
      let(:method_name) { :+ }
    end

    it "converts given value" do
      subject.should_receive(:to_self).with(subject).and_return(subject)

      subject + subject
    end

    it "returns sum of degrees" do
      expect((subject + subject).degrees).to eq 20
    end
  end

  describe "#-" do
    it_should_behave_like "returning new instance" do
      let(:method_name) { :- }
    end

    it "returns dfference between degrees" do
      expect((subject - subject).degrees).to eq 0
    end
  end

  describe "#*" do
    it_should_behave_like "returning new instance" do
      let(:method_name) { :* }
    end

    it "returns degrees multiplied by value" do
      expect((subject * 10).degrees).to eq 100
    end
  end

  describe "#/" do
    it_should_behave_like "returning new instance" do
      let(:method_name) { :/ }
    end

    it "returns degrees divided by value" do
      expect((subject / 10).degrees).to eq 1
    end
  end

  describe "#==" do
    subject { WeatherData::Temperature::Base }
    
    it "can be compared to Numeric" do
      expect(subject.new(10) == 10).to be_true
      expect(subject.new(10) == 10.0).to be_true
      expect(subject.new(10) == 11).to be_false
    end
  end

  describe "#to_i" do
    subject { WeatherData::Temperature::Base }

    it "returns degrees rounded" do
      expect(subject.new(15.6).to_i).to eq 16
      expect(subject.new(15.1).to_i).to eq 15
    end
  end

  describe "#to_f" do
    subject { WeatherData::Temperature::Base }

    it "returns degrees" do
      expect(subject.new(15.6).to_f).to eq 15.6
      expect(subject.new(15.1).to_f).to eq 15.1
    end
  end
end
