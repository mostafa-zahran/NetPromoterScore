class PromoterScores::FilterPromoterScore
  class TouchpointIsMissing < StandardError
    def message
      'Touchpoint is missing'
    end
  end

  def self.call(params)
    raise TouchpointIsMissing if params[:touchpoint].blank?
    ActiveRecord::Base.connection.execute(PromoterScore.where(params).to_sql).to_a
  end
end