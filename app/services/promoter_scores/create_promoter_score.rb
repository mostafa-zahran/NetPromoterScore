class PromoterScores::CreatePromoterScore
  def self.call(params)
    Agents::ValidateAgentPresence.call(agent_params(params))
    Respondents::ValidateRespondentPresence.call(respondent_params(params))
    PromoterScore.create!(params)
  end

  def self.agent_params(params)
    {id: params[:object_id], type: params[:object_class]}
  end

  def self.respondent_params(params)
    {id: params[:respondent_id], type: params[:respondent_class]}
  end
end