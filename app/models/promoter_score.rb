class PromoterScore < ApplicationRecord
  ALLOWED_TOUCHPOINTS = %w[realtor_feedback].freeze

  # -1 is act as a place holder when record created but no submission happened yet
  ALLOWED_SCORES = (-1..9).to_a

  validates_inclusion_of :score, in: ALLOWED_SCORES
  validates_inclusion_of :touchpoint, in: ALLOWED_TOUCHPOINTS
end
