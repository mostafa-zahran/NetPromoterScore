require 'rails_helper'

RSpec.describe Agents::ValidateAgentPresence do
  let(:valid_params) {
    {
        type: 'object_class',
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
      expect { described_class.call({}) }.to raise_error(Agents::ValidateAgentPresence::AgentNotPresent)
    end
  end
end