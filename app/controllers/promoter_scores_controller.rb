class PromoterScoresController < ApplicationController
  def create
    promoter_score = PromoterScores::CreatePromoterScore.call(promoter_score_params)
    render json: { promoter_score: promoter_score }, status: :created
  rescue ActiveRecord::RecordInvalid, ActiveRecord::NotNullViolation => e
    render json: { error: e }, status: :bad_request
  rescue Agents::ValidateAgentPresence::AgentNotPresent,
      Respondents::ValidateRespondentPresence::RespondentNotPresent,
      SellingTransactions::ValidateSellingTransactionPresence::SellingTransactionNotPresent => e
    render json: { error: e.message }, status: :bad_request
  end

  def filter
    promoter_scores = PromoterScores::FilterPromoterScore.call(filter_promoter_score_params)
    render json: { promoter_scores: promoter_scores}, status: :ok
  rescue PromoterScores::FilterPromoterScore::TouchpointIsMissing => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def promoter_score_params
    params
        .require(:promoter_score)
        .permit(:score,
                :object_id,
                :object_class,
                :respondent_id,
                :respondent_class,
                :touchpoint)
  end

  def filter_promoter_score_params
    params.require(:filters).permit(:object_class, :respondent_class, :touchpoint)
  end
end