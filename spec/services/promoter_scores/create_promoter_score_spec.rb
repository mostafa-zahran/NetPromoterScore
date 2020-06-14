require 'rails_helper'

RSpec.describe PromoterScores::CreatePromoterScore do
  let(:valid_params) {
    {
        object_class: 'object_class',
        object_id: Faker::Number.non_zero_digit,
        respondent_id: Faker::Number.non_zero_digit,
        respondent_class: 'respondent_class',
        touchpoint: 'realtor_feedback',
        score: Faker::Number.between(from: 0, to: 10)
    }
  }

  before {
    allow(PromoterScore).to receive(:create!).and_return(valid_params)
    allow(Agents::ValidateAgentPresence).to receive(:call).and_return(true)
  }

  it 'call create! on the PromoterScore' do
    expect(PromoterScore).to receive(:create!)
    expect(Agents::ValidateAgentPresence).to receive(:call)
    described_class.call({})
  end
end