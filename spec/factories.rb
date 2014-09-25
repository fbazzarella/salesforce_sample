FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "johndoe-#{n}"
    end

    password 'secret'
  end

  factory :person do
    last_name 'Doe'
  end
end
