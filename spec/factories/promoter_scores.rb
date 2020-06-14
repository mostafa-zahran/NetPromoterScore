FactoryGirl.define do
  factory :promoter_score do
    initialize_with {
      new(object_class: 'object_class',
          object_id: Faker::Number.non_zero_digit,
          respondent_id: Faker::Number.non_zero_digit,
          respondent_class: 'respondent_class',
          touchpoint: 'realtor_feedback',
          score: Faker::Number.between(from: 0, to: 10))
    }
  end
end
