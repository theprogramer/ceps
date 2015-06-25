# enconding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Correios::Setup do
  let(:setup) { Correios::Setup.new }

  it 'responds to ceps' do
    expect(setup.ceps).to be_a Hash
  end
end
