FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    stripe_token 'asdfasdfasdfasdf'
    address '111 First St.'
    city 'Some town'
    state 'Missouri'
    zipcode '65656'
  end
end
