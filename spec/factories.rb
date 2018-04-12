FactoryBot.define do
  factory :feature do
    title 'Some Movie'
    release 2000
    # director_id attributes_for(:director)[:id]
    # cast [actor, actor, actor]
  end
end
