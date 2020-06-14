class PromoterScores::CreatePromoterScore
  def self.call(params)
    PromoterScore.create!(params)
  end
end