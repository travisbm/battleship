FactoryGirl.define do
  factory :game do

    trait :score_no_shots do
      shots 0
      score 10850
    end
  end
end
