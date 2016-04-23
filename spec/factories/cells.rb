FactoryGirl.define do
  factory :cell do
    game
  end

  trait :ship do
    status "Boat"
  end
end
