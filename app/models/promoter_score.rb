class PromoterScore < ApplicationRecord
  ALLOWED_TOUCHPOINTS = %w[realtor_feedback].freeze

  # -1 is act as a place holder when record created but no submission happened yet
  ALLOWED_SCORES = (-1..9).to_a

  validates_inclusion_of :score, in: ALLOWED_SCORES, message: "has invalid value."
  validates_inclusion_of :touchpoint, in: ALLOWED_TOUCHPOINTS, message: "has invalid value."
  validates_presence_of :object_class, :object_id, :respondent_class, :respondent_id
end
