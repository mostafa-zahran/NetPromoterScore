# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PromoterScoresController do
  let(:valid_params) {
    {
        promoter_score: {
            object_class: 'object_class',
            object_id: Faker::Number.non_zero_digit,
            respondent_id: Faker::Number.non_zero_digit,
            respondent_class: 'respondent_class',
            touchpoint: 'realtor_feedback',
            score: Faker::Number.between(from: 0, to: 10)
        },
        format: :json
    }
  }
  describe '#create' do
    context "success" do
      it 'creates promoter score' do
        expect {
          post :create, params: valid_params
        }.to change { PromoterScore.count }.by(1)
        expect(response.code).to eql('201')
        valid_params[:promoter_score].each do |att_name|
          expect(json_response[:promoter_score][att_name]).to eql(valid_params[:promoter_score][att_name])
        end
      end
    end

    context "fail" do
      def test_value_not_present(attribute)
        no_attribute_params = valid_params.deep_dup
        no_attribute_params.fetch(:promoter_score).delete(attribute)
        post :create, params: no_attribute_params
        expect(response.code).to eql('400')
      end

      it 'has no score' do
        test_value_not_present(:score)
        expect(json_response[:error]).to eql("Validation failed: Score has invalid value.")
      end

      it 'has no touchpoint' do
        test_value_not_present(:touchpoint)
        expect(json_response[:error]).to eql("Validation failed: Touchpoint has invalid value.")
      end

      it 'has no object_class' do
        test_value_not_present(:object_class)
        expect(json_response[:error]).to eql("Validation failed: Object class can't be blank")
      end

      it 'has no object_id' do
        test_value_not_present(:object_id)
        expect(json_response[:error]).to eql("Validation failed: Object can't be blank")
      end

      it 'has no respondent_id' do
        test_value_not_present(:respondent_id)
        expect(json_response[:error]).to eql("Validation failed: Respondent can't be blank")
      end

      it 'has no respondent_class' do
        test_value_not_present(:respondent_class)
        expect(json_response[:error]).to eql("Validation failed: Respondent class can't be blank")
      end
    end
  end
end
