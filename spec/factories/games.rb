FactoryGirl.define do
  factory :game do
  end

  trait :score do
    score       10850

    after(:build) do |game|
      game.class.skip_callback(:create, :after, :set_initial_score)
    end
  end
end
