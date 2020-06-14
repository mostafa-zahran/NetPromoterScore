require 'rails_helper'

RSpec.describe PromoterScores::CreatePromoterScore do
  it 'call create! on the PromoterScore' do
    allow(PromoterScore).to receive(:create!).and_return({})
    expect(PromoterScore).to receive(:create!)
    described_class.call({})
  end
end