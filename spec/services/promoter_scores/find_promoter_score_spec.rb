require 'rails_helper'

RSpec.describe PromoterScores::FindPromoterScore do
  it 'find the correct object' do
    promoter_score = create(:promoter_score)
    valid_params = {
        object_id: promoter_score.object_id,
        object_class: promoter_score.object_class,
        respondent_class: promoter_score.respondent_class,
        respondent_id: promoter_score.respondent_id,
        touchpoint: promoter_score.touchpoint
    }
    expect(described_class.call(valid_params)).to eq(promoter_score)
  end

  it 'returns nil if not found' do
    promoter_score = create(:promoter_score)
    valid_params = {
        object_id: promoter_score.object_id,
        object_class: promoter_score.object_class,
        respondent_class: promoter_score.respondent_class,
        respondent_id: promoter_score.respondent_id,
        touchpoint: 'somthing else'
    }
    expect(described_class.call(valid_params)).to eq(nil)
  end
end