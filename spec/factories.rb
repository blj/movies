FactoryBot.define do
  # factory :actor do
  #   name "Some Actor"
  # end
  # factory :director do
  #   name "Some Director"
  # end

  factory :feature do
    title "Some Movie"
    release 2000
    # director
    # cast [actor, actor, actor]
  end
end
