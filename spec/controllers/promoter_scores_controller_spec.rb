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
        post :create, params: valid_params
        expect(response.code).to eql('201')
        valid_params[:promoter_score].each do |att_name|
          expect(json_response[:promoter_score][att_name]).to eql(valid_params[:promoter_score][att_name])
        end
      end
    end

    context "fail" do
      def test_value_not_present(attribute)
        old_value = valid_params.fetch(:promoter_score).delete(attribute)
        post :create, params: valid_params
        valid_params[attribute] = old_value
        expect(response.code).to eql('400')
      end

      it 'has no score' do
        test_value_not_present(:score)
        expect(json_response[:error]).to eql("Validation failed: Score has invalid value.")
      end

      it 'has no touchpoint' do
        test_value_not_present(:touchpoint)
        expect(json_response[:error]).to eql("Selling Transaction not found")
      end

      it 'has no object_class' do
        test_value_not_present(:object_class)
        expect(json_response[:error]).to eql("Object not found")
      end

      it 'has no object_id' do
        test_value_not_present(:object_id)
        expect(json_response[:error]).to eql("Object not found")
      end

      it 'has no respondent_id' do
        test_value_not_present(:respondent_id)
        expect(json_response[:error]).to eql("Respondent not found")
      end

      it 'has no respondent_class' do
        test_value_not_present(:respondent_class)
        expect(json_response[:error]).to eql("Respondent not found")
      end
    end
  end

  describe "#filter" do
    context "fail" do
      it 'has no touchpoint' do
        params = {
            filters: {
                object_class: 'object_class',
                respondent_class: 'respondent_class'
            },
            format: :json
        }
        get :filter, params: params
        expect(response.code).to eql('400')
        expect(json_response[:error]).to eql("Touchpoint is missing")
      end
    end

    context "success" do
      let!(:ps_oc2_rc1) { create(:promoter_score,
                                object_class: 'object_class2',
                                respondent_class: 'respondent_class1',
                                touchpoint: 'realtor_feedback')}
      let!(:ps_oc1_rc2) { create(:promoter_score,
                                object_class: 'object_class1',
                                respondent_class: 'respondent_class2',
                                touchpoint: 'realtor_feedback')}

      def success_test(objs)
        expect(response.code).to eql('200')
        res = json_response[:promoter_scores].map{|r| r.values_at(:object_class, :object_id, :id, :respondent_class, :respondent_id, :touchpoint)}
        exp = objs.map{|r| r.attributes.values_at(:object_class, :object_id, :id, :respondent_class, :respondent_id, :touchpoint)}
        expect(res).to eq(exp)
      end
      it 'find all with touchpoint only' do
        params = {
            filters: {
                touchpoint: ps_oc2_rc1.touchpoint
            },
            format: :json
        }
        get :filter, params: params
        success_test([ps_oc2_rc1, ps_oc1_rc2])
      end

      it 'find all with touchpoint and object_class only' do
        params = {
            filters: {
                touchpoint: ps_oc2_rc1.touchpoint,
                object_class: ps_oc2_rc1.object_class
            },
            format: :json
        }
        get :filter, params: params
        success_test([ps_oc2_rc1])
      end

      it 'find all with touchpoint and object_class only' do
        params = {
            filters: {
                touchpoint: ps_oc2_rc1.touchpoint,
                object_class: ps_oc1_rc2.object_class
            },
            format: :json
        }
        get :filter, params: params
        success_test([ps_oc1_rc2])
      end
    end
  end
end
