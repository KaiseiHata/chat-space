include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :message do
    body       Faker::Lorem.sentence
    image      { fixture_file_upload("#{::Rails.root}/spec/fixtures/img/kasumi.jpg", 'image/jpg') }
    user_id    Faker::Number.between(1, 100)
    group_id   Faker::Number.between(1, 100)
  end

end