FactoryGirl.define do
  factory :user do
    username 'johndoe'
    password 'secret'
  end

  factory :person do
    last_name 'Doe'
  end
end
