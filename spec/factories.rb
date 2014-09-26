FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "johndoe-#{n}"}
    password 'secret'
  end

  factory :person do
    user
    name      'John'
    last_name 'Doe'
    email     'johndoe@example.com'
    company   'johndoe'
    job_title 'ceo'
    phone     '555 9999'
    website   'johdoe.com'
  end
end
