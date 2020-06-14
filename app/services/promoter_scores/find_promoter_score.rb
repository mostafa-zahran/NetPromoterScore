class PromoterScores::FindPromoterScore
  def self.call(params)
    PromoterScore.find_by(params)
  end
end