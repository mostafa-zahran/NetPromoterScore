require 'rails_helper'

RSpec.describe SellingTransactions::ValidateSellingTransactionPresence do
  let(:valid_params) {
    {
        object_class: 'object_class',
        object_id: Faker::Number.non_zero_digit,
        respondent_class: 'respondent_class',
        respondent_id: Faker::Number.non_zero_digit
    }
  }

  context "success" do
    it 'returns true if valid params passed' do
      expect(described_class.call(valid_params)).to eq(true)
    end
  end

  context "fail" do
    it 'raises error if invalid params passed' do
      expect { described_class.call({}) }.to raise_error(SellingTransactions::ValidateSellingTransactionPresence::SellingTransactionNotPresent)
    end
  end
end