FactoryGirl.define do
  factory :user do
    name                    "Caleb"
    email                   "caleb@example.com"
    password                "foobar"
    password_confirmation   "foobar"
  end
end
