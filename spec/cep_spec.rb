# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Correios::Cep do
  
  let(:cep) { Correios::Cep.search(20000000) }

  it 'allows to create a country object from an integer' do
    cep = described_class.new(20000000)
    expect(cep.ceps).not_to be_nil
  end

  it 'should return Carioca location' do
    expect(cep.location).to eq('Carioca')
  end

  it 'should return Rua type' do
    expect(cep.type).to eq('Rua')
  end

  it 'should return Centro neighborhood' do
    expect(cep.neighborhood).to eq('Centro')
  end

  it 'should return Rio de Janeiro city name' do
    expect(cep.city).to eq('Rio de Janeiro')
  end

  it 'should return Rio de Janeiro state name' do
    expect(cep.state).to eq('Rio de Janeiro')
  end

  describe 'valid?' do
    it 'should return true if cep is valid' do
      expect(Correios::Cep.new(10000000)).to be_valid
    end

    it 'should return false if cep is invalid' do
      expect(Correios::Cep.new({})).not_to be_valid
    end
  end

  describe 'new' do
    it 'should return new cep object when a valid cep string is passed' do
      expect(Correios::Cep.new(20000000)).to be_a(Correios::Cep)
    end

    it 'should return nil when an invalid cep is passed' do
      expect(Correios::Cep.new(00000000)).to be_nil
    end

  end

  describe 'Cep class' do
    context "when loaded via 'Correios' existance" do
      subject { defined?(Cep) }

      it { is_expected.to be_falsey }
    end

    context "when loaded via 'ceps'" do
      before { require 'ceps' }

      describe 'existance' do
        subject { defined?(Cep) }

        it { is_expected.to be_truthy }
      end

      describe 'superclass' do
        subject { Cep.superclass }

        it { is_expected.to eq(Correios::Cep) }
      end

      # describe 'to_s' do
      #   it 'should return the cep key' do
      #     expect(Cep.new(20000000).to_s).to eq('20000-000')
      #   end
      # end
    end
  end

end