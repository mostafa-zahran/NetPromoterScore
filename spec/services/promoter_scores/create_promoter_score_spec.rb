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
    allow(PromoterScore).to receive(:create!)
    allow(Agents::ValidateAgentPresence).to receive(:call).and_return(true)
    allow(Respondents::ValidateRespondentPresence).to receive(:call).and_return(true)
    allow(SellingTransactions::ValidateSellingTransactionPresence).to receive(:call).and_return(true)
  }

  it 'perform validations' do
    expect(Agents::ValidateAgentPresence).to receive(:call)
    expect(Respondents::ValidateRespondentPresence).to receive(:call)
    expect(SellingTransactions::ValidateSellingTransactionPresence).to receive(:call)
    described_class.call({})
  end

  it "creates if object not found" do
    allow(PromoterScores::FindPromoterScore).to receive(:call).and_return(nil)
    expect(PromoterScore).to receive(:create!).with(valid_params)
    described_class.call(valid_params)
  end

  it "updates score if object is found" do
    promoter_score = create(:promoter_score)
    allow(promoter_score).to receive(:update_attributes)
    allow(PromoterScores::FindPromoterScore).to receive(:call).and_return(promoter_score)
    expect(promoter_score).to receive(:update_attributes).with({score: valid_params[:score]})
    described_class.call(valid_params)
  end
end