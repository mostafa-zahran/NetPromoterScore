require 'rails_helper'

RSpec.describe PromoterScores::FilterPromoterScore do
  let(:promoter_score) { create(:promoter_score) }
  it 'raises if touchpoint is not passed' do
    params = {
        object_class: promoter_score.object_class,
        respondent_class: promoter_score.respondent_class
    }
    expect{described_class.call(params)}.to raise_error(PromoterScores::FilterPromoterScore::TouchpointIsMissing)
  end

  it 'returns valid hash if params are valid' do
    params = {
        object_class: promoter_score.object_class,
        respondent_class: promoter_score.respondent_class,
        touchpoint: promoter_score.touchpoint
    }
    res = described_class.call(params).first.values_at(:object_class, :object_id, :id, :respondent_class, :respondent_id, :touchpoint)
    exp = promoter_score.attributes.values_at(:object_class, :object_id, :id, :respondent_class, :respondent_id, :touchpoint)
    expect(res).to eq(exp)
  end
end