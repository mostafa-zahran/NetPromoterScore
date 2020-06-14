require 'rails_helper'

RSpec.describe PromoterScore, type: :model do
  describe "ALLOWED_TOUCHPOINTS" do
    it "have a certain values" do
      expect(PromoterScore::ALLOWED_TOUCHPOINTS).to eq(%w[realtor_feedback])
    end
  end

  describe "ALLOWED_SCORES" do
    it "have a certain values" do
      expect(PromoterScore::ALLOWED_SCORES).to eq((-1..9).to_a)
    end
  end

  describe "Creation" do
    context "success" do
      it "has all attributes exist" do
        expect { create(:promoter_score) }.to change { PromoterScore.count }.by(1)
      end
    end

    context "fail" do
      it "has no score" do
        expect { create(:promoter_score, score: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "has no object_id" do
        expect { create(:promoter_score, object_id: nil) }.to raise_error(ActiveRecord::NotNullViolation)
      end

      it "has no object_class" do
        expect { create(:promoter_score, object_class: nil) }.to raise_error(ActiveRecord::NotNullViolation)
      end

      it "has no respondent_class" do
        expect { create(:promoter_score, respondent_class: nil) }.to raise_error(ActiveRecord::NotNullViolation)
      end

      it "has no respondent_id" do
        expect { create(:promoter_score, respondent_id: nil) }.to raise_error(ActiveRecord::NotNullViolation)
      end

      it "has no touchpoint" do
        expect { create(:promoter_score, touchpoint: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
