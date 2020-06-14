class PromoterScores::CreatePromoterScore
  def self.call(params)
    Agents::ValidateAgentPresence.call(agent_params(params))
    Respondents::ValidateRespondentPresence.call(respondent_params(params))
    SellingTransactions::ValidateSellingTransactionPresence.call(selling_transaction_params(params))
    PromoterScore.create!(params)
  end

  def self.agent_params(params)
    {id: params[:object_id], type: params[:object_class]}
  end

  def self.respondent_params(params)
    {id: params[:respondent_id], type: params[:respondent_class]}
  end

  def self.selling_transaction_params(params)
    {
        object_id: params[:object_id],
        object_class: params[:object_class],
        respondent_id: params[:respondent_id],
        respondent_class: params[:respondent_class]
    }
  end
end