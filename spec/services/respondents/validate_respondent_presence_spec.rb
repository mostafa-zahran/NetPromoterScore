require 'rails_helper'

RSpec.describe Respondents::ValidateRespondentPresence do
  let(:valid_params) {
    {
        type: 'respondent_class',
        id: Faker::Number.non_zero_digit
    }
  }

  context "success" do
    it 'returns true if valid params passed' do
      expect(described_class.call(valid_params)).to eq(true)
    end
  end

  context "fail" do
    it 'raises error if invalid params passed' do
      expect { described_class.call({}) }.to raise_error(Respondents::ValidateRespondentPresence::RespondentNotPresent)
    end
  end
end