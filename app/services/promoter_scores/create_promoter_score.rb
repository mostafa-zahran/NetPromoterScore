class PromoterScores::CreatePromoterScore
  def self.call(params)
    Agents::ValidateAgentPresence.call(agent_params(params))
    PromoterScore.create!(params)
  end

  def self.agent_params(params)
    {id: params[:object_id], type: params[:object_class]}
  end
end